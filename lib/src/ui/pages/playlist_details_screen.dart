import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_playlist_app/src/models/playlist.dart';
import 'package:magic_playlist_app/src/models/spotify_auth.dart';
import 'package:magic_playlist_app/src/services/api_services.dart';
import 'package:magic_playlist_app/src/services/spotify_auth.dart';
import 'package:magic_playlist_app/src/ui/widgets/song_card.dart';


class PlaylistDetailsScreen extends StatefulWidget {
  PlaylistDetailsScreen({Key? key, required this.id}) : super(key: key);

  String id;

  @override
  _PlaylistDetailsScreenState createState() => _PlaylistDetailsScreenState();
}

class _PlaylistDetailsScreenState extends State<PlaylistDetailsScreen> {


  Future<Playlist> fetchPlaylistData() async {
    // SpotifyAuth credentials = await SpotifyAuthToken.getSpotifyToken();
    SpotifyAuth credentials = await SpotifyAuthToken.loadCredentials();
    final playlist = getPlaylistById(widget.id);
    playlist.then((value) => print(value.info.id));
    return playlist;
  }


  @override
  Widget build(BuildContext context) {

    var _width = MediaQuery.of(context).size.width;

    return Scaffold( 
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          width: _width,
          child: FutureBuilder<Playlist>(
            future: fetchPlaylistData(),
            builder: (BuildContext context, AsyncSnapshot<Playlist> snapshot) => 
              snapshot.hasData
                ? _playlistList(context, snapshot.data)
                : const Center(child: CircularProgressIndicator())
            ,
          )
        ),
      ),
    );
  }

  Widget _playlistList(BuildContext context, Playlist? data) {
    var _width = MediaQuery.of(context).size.width;
    return Column(
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
                        tag: widget.id,
                        child: Image.network(data!.info.image, width: _width, height: _width,)
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
                          child: Text(data.info.name,
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  height: MediaQuery.of(context).size.height - 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.songs.length,
                    itemBuilder: (BuildContext context, index) => 
                    SongCard(
                      id: data.songs[index].id, 
                      img: data.songs[index].albumImage, 
                      title: data.songs[index].name, 
                      artist: data.songs[index].artists
                    ),
                  ),
                )
              ],
            ),
          )
        ]
    );
  }
}