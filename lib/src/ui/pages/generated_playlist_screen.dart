import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_playlist_app/src/models/generated_playlist.dart';
import 'package:magic_playlist_app/src/services/api_services.dart';
import 'package:magic_playlist_app/src/ui/widgets/song_card.dart';

import 'home_screen.dart';


class GeneratedPlaylistScreen extends StatefulWidget {
  GeneratedPlaylistScreen({Key? key, required this.referenceId, required this.playlistName, required this.playlistSize}) : super(key: key);

  String referenceId;
  String playlistName;
  int playlistSize;

  @override
  _GeneratedPlaylistScreenState createState() => _GeneratedPlaylistScreenState();
}

class _GeneratedPlaylistScreenState extends State<GeneratedPlaylistScreen> {
  
  List<String> ids = [];
  late Future<GeneratedPlaylist> data;

  @override
  void initState() {
    super.initState();
    data = generatePlaylist(widget.referenceId, 20);
    data.then((value) => 
      ids = value.ids
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.playlistName,
            textAlign: TextAlign.center,
            style: GoogleFonts.comfortaa(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          )
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: null,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: FutureBuilder<GeneratedPlaylist>(
          future: data,
          builder: (context, snapshot) => 
            snapshot.hasData 
            ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: snapshot.data!.songs.length,
                itemBuilder: (context, index) {
                  return SongCard(
                    id: snapshot.data!.songs[index].id,
                    img: snapshot.data!.songs[index].albumImage, 
                    title: snapshot.data!.songs[index].name,
                    artist: snapshot.data!.songs[index].artists
                  );
                },
              ),
            )
            : const Center(child: CircularProgressIndicator())
          ,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          saveGeneratedPlaylist(widget.playlistName, ids),
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()))
        },
        // onPressed: () => print(ids.toString()),
        child: const Icon(Icons.check),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}