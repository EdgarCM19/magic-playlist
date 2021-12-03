import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:magic_playlist_app/src/models/spotify_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpotifyAuthToken {

  static const String clientId = '38e8fd759dfb435096daf92ac80c9377';
  static const String secret = '7cac1c074b1d4ec5b30924c714168850';

  static Future<String> getSpotifyCode() async {
    String url = "https://accounts.spotify.com/authorize";
    String responseType = "code";
    String redirectUri = "magicplaylist:/";
    String scope = "playlist-read-private playlist-modify-public playlist-read-collaborative playlist-modify-private user-library-modify";
    String state = "34fFs29kd09";

    String urlDireccion = 
      url +
      "?client_id=$clientId" +
      "&response_type=$responseType" +
      "&redirect_uri=$redirectUri" +
      "&scope=$scope" +
      "&state=$state";

    final response = await FlutterWebAuth.authenticate(
      url: urlDireccion, 
      callbackUrlScheme: "magicplaylist"
    );
    
    final error = Uri.parse(response).queryParameters['error'];
    if (error == null) {
      final code = Uri.parse(response).queryParameters['code'];
      
      return code!;
    } else {
      return error;
    }

  }

  static Future<SpotifyAuth> getSpotifyToken() async {

    String code = await getSpotifyCode();  
    // print('CODEEEE:  '+code); 

    Client client = Client();

    String authorizationStr = "$clientId:$secret";
    var bytes = utf8.encode(authorizationStr);
    var base64Str = base64.encode(bytes);

    String authorization = 'Basic ' + base64Str;

    var urlToToken = 'https://accounts.spotify.com/api/token';

    var responseToken = await client.post(Uri.parse(urlToToken), body: {
      'grant_type': "authorization_code",
      'code': code,
      'redirect_uri': 'magicplaylist:/'
    }, headers: {'Authorization' : authorization});
    if (responseToken.statusCode == 200) {
      return SpotifyAuth.fromJson(json.decode(responseToken.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static void saveCredentials(SpotifyAuth credentials) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', credentials.accessToken);
    prefs.setString('refresh', credentials.refreshToken);
    prefs.setString('type', credentials.tokenType);
    prefs.setString('scope', credentials.scope);
  }
  
  static Future<SpotifyAuth> loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? 'none';
    String type = prefs.getString('type') ?? 'none';
    String refresh = prefs.getString('refrest') ?? 'none';
    String scope = prefs.getString('scope') ?? 'none';

    return 
    SpotifyAuth(
      accessToken: token,
      tokenType: type,
      refreshToken: refresh,
      scope: scope
    );

  }

  static void deleteCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('type');
    prefs.remove('refresh');
    prefs.remove('scope');
  }
}