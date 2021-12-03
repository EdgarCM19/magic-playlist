import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_playlist_app/src/ui/widgets/song_card.dart';

class PlaylistDetails extends StatelessWidget {
  const PlaylistDetails({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    // final playlistData = getPlaylistById(id);

    return Scaffold( 
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        // minimum: const EdgeInsets.all(24.0),
        child: Container(
          width: _width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
                        child: Hero(
                          tag: id,
                          child: Image.asset('assets/img/img_2.jpg', width: _width, height: _width,)
                          ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: Container(
                            width: _width,
                            height: _width,
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.only(bottom: 24),
                            color: Colors.black.withOpacity(0.2),
                            child: Text("",
                              style: GoogleFonts.comfortaa(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // const SongCard(id: 1, img: 'assets/img/img_2.jpg', title: 'Titulo 1', artist: 'Artista xd'),
                  // const SongCard(id: 2, img: 'assets/img/img_3.jpg', title: 'Titulo 2', artist: 'Artista xd'),
                  // const SongCard(id: 3, img: 'assets/img/img_4.jpg', title: 'Titulo 3', artist: 'Artista xd'),
                  // const SongCard(id: 4, img: 'assets/img/img_7.jpg', title: 'Titulo 4', artist: 'Artista xd'),
                  ]
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}