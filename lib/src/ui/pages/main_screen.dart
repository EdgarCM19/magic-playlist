import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_playlist_app/src/models/spotify_auth.dart';
import 'package:magic_playlist_app/src/services/api_services.dart';
import 'package:magic_playlist_app/src/services/spotify_auth.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  void funcAuth() async {
    // print('Entro a autenticacion');
    // final credentials = await SpotifyAuthToken.getSpotifyToken();
    // print('Salgo de autenticacion');
    // final playlists = await getPlaylists(credentials.accessToken);
    // print(playlists.length);
  }



  void fetchPlaylist() async {
    SpotifyAuth credentials = await SpotifyAuthToken.loadCredentials();
    final res = await getPlaylistById('37i9dQZF1EUMDoJuT8yJsl');
    print('@@@@@ ' + res.songs.length.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // // ----- Profile -----
            // Container(
            //   margin: const EdgeInsets.only(top: 24.0),
            //   child: Row(
            //     children: [
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(8.0),
            //         child: Image.asset('assets/img/profile.jpg', width: 72, height: 72,)
            //       ),
            //       const SizedBox(width: 24,),
            //       Column(
            //         // mainAxisAlignment: ,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             'Bienvenida/o', 
            //             style: GoogleFonts.comfortaa(
            //               color: Theme.of(context).colorScheme.primary,
            //               fontSize: 30, 
            //               fontWeight: FontWeight.w500
            //             ),
            //           ),
            //           Text(
            //             'usuario', 
            //             style: GoogleFonts.comfortaa(
            //               color: Theme.of(context).colorScheme.primaryVariant,
            //               fontSize: 24, 
            //               fontWeight: FontWeight.w400
            //             )
            //           )
            //         ],
            //       )
            //   ],),
            // ),
            // // ----- Lists -----
            // // Container(
            // //   child: 
            // //   playlistData.isNotEmpty ?
            // //     const PlaylistList(data: playlistData)
            // //   :
            // //     const NoLists()
            // //   ,
            // // )
            TextButton(
              onPressed: fetchPlaylist,
              child: const Text('Obtener credenciales'),
            ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context, 
          builder: (context) => _buildSheet(context),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            )
          )
        ),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSheet(context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Seleccione una playlist'),

      ElevatedButton(
        onPressed: () => {
          Navigator.of(context).pop(),
          showModalBottomSheet(
            context: context, 
            builder: (context) => _modal2(context)
          ),
        }, 
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
  );

  Widget _modal2(context) => Column(
    // mainAxisSize: MainAxisSize.min,
    children: const [
      Text('Modal 2')
    ],
  );

}