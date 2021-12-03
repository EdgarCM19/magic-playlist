import 'package:magic_playlist_app/src/models/song.dart';

class GeneratedPlaylist {

  final List<String> ids;
  final List<Song> songs;

  const GeneratedPlaylist({ required this.ids, required this.songs});

  factory GeneratedPlaylist.fromJson(Map<String, dynamic> json) {
    List<dynamic> ids = json['ids'];
    List<dynamic> jsonSongs = json['songInfo'];
    List<Song> songs = jsonSongs
                        .map<Song>((e) => Song.fromJson(e))
                        .toList();
    return GeneratedPlaylist(
      ids: ids.map<String>((e) => e.toString()).toList(),
      songs: songs
    );
  }

}