import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:magic_playlist_app/src/models/generated_playlist.dart';
import 'package:magic_playlist_app/src/models/playlist.dart';
import 'package:magic_playlist_app/src/models/playlist_info.dart';
import 'package:http/http.dart' as http;
import 'package:magic_playlist_app/src/models/user.dart';
import 'package:magic_playlist_app/src/services/spotify_auth.dart';

// const String API_URL = 'http://10.0.0.17:5000';
// const String API_URL = 'http://172.29.99.181:5000';
const String API_URL = 'http://hdedurazno.pythonanywhere.com/';


Future<User> getUserInfo() async {
  final credentials = await SpotifyAuthToken.loadCredentials();
  const url = API_URL + '/userInfo';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'SpotifyToken': credentials.accessToken,
      'content-Type': 'application/json'
    }
  ).timeout(const Duration(seconds: 10));
  if(response.statusCode == 200){
    debugPrint(response.body);
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw('Error al obtener los datos');
  }
}


Future<List<PlaylistInfo>> getPlaylists() async {
  final credentials = await SpotifyAuthToken.loadCredentials();
  const url = API_URL + '/getAllPlaylists';
  final response = await http.get(
    Uri.parse(url),
    headers: { 
      'SpotifyToken': credentials.accessToken,  
      'content-Type': 'application/json'
    }
  ).timeout(const Duration(seconds: 10));
  if(response.statusCode == 200){
    final Map json = jsonDecode(response.body);
    // print(json['msg']);
    return PlaylistInfo.fromJsonList(json['Playlists']);
  } 
  return [];
}

Future<Playlist> getPlaylistById(String id) async {
  print('@@@' + id);
  final credentials = await SpotifyAuthToken.loadCredentials();
  final url = API_URL + '/infoPlaylist/' + id;
  http.Client client = http.Client();
  final response = await client.get(
    Uri.parse(url),
    headers: { 
      'SpotifyToken': credentials.accessToken,  
      'content-Type': 'application/json'
    }
  ).timeout(const Duration(seconds: 10));
  if(response.statusCode == 200){
    Playlist playlist = Playlist.fromJson(jsonDecode(response.body));
    return playlist;
    } else {
    throw Exception("Error al obtener data");
  }
}


Future<GeneratedPlaylist> generatePlaylist(String id, int size) async {
  final credentials = await SpotifyAuthToken.loadCredentials();
  final url = API_URL + '/generatePlaylist/$size/$id';
  final response = await http.Client().get(
    Uri.parse(url),
    headers: { 
      'SpotifyToken': credentials.accessToken,  
      'content-Type': 'application/json'
    },
  ).timeout(const Duration(seconds: 10));
  if(response.statusCode == 200){
    final resp = jsonDecode(response.body);
    // debugPrint(response.body);
    return GeneratedPlaylist.fromJson(resp);
  } else {
    throw('Error');
  }
}

Future<String> saveGeneratedPlaylist(String name, List<String> ids) async {
  final credentials = await SpotifyAuthToken.loadCredentials();
  const url = API_URL + '/savePlaylist';

  Map<String, dynamic> jsonBody = {
    'name': name,
    'ids': ids,
  };
  var bodyJson = json.encode(jsonBody);
  print(bodyJson);
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'SpotifyToken': credentials.accessToken,
      'content-Type': 'application/json'
    },
    body: bodyJson,
  ).timeout(const Duration(seconds: 20));
  if(response.statusCode == 200){
    final json = jsonDecode(response.body);
    print('SIIIIUUUUUUUUUUUUUUU se guardooooooo');
    debugPrint('------' + response.body);
    return json['msg'];
  } else {
    print('Estas pendejpo ' + response.body.toString());
  }
  return '';
}