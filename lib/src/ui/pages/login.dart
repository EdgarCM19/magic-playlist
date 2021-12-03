import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_playlist_app/src/models/spotify_auth.dart';
import 'package:magic_playlist_app/src/services/spotify_auth.dart';
import 'package:magic_playlist_app/src/ui/pages/home_screen.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  Future<bool> isLoged() async{
    SpotifyAuth credentials = await SpotifyAuthToken.loadCredentials();
    return credentials.accessToken != 'none';
  }

  loginProcess(context) async {
    // if(await isLoged()){
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    // } else {
      SpotifyAuthToken.deleteCredentials();
      SpotifyAuth credentials = await SpotifyAuthToken.getSpotifyToken();
      print('^^^^^^' + credentials.accessToken);
      // print(credentials.accessToken);
      SpotifyAuthToken.saveCredentials(credentials);
      // MaterialPageRoute(builder: (context) => const HomeScreen());
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 145.0),
                  SvgPicture.asset(
                    'assets/svg/logo.svg',
                    color: Colors.white,
                    width: 256,
                    height: 256,
                  ),
                  const SizedBox(height: 128.0),
                  ElevatedButton(
                    // onPressed: () => loginProcess(context), 
                    onPressed: () => loginProcess(context), 
                    child: Text('Ingresar', 
                      style: GoogleFonts.poppins(
                      // style: GoogleFonts.sourceCodePro(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2.0
                      )
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 120.0,),
              Text('Magic Playlist', style: GoogleFonts.comfortaa(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary)),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        )
      ,),
    );
  }
}