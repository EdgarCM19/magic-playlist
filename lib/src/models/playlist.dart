import 'package:flutter/foundation.dart';
import 'package:magic_playlist_app/src/models/playlist_info.dart';
import 'package:magic_playlist_app/src/models/song.dart';

class Playlist {

  const Playlist({ required this.info, required this.songs });

  final PlaylistInfo info;
  final List<Song> songs;

  factory Playlist.fromJson(Map<String, dynamic> json) {
    final PlaylistInfo info = PlaylistInfo.fromJson(json['PlaylistInfo']);
    debugPrint('####' + info.name);
    // debugPrint(json['msg']);
    // debugPrint('!!!!' + json['songList']);
    List<dynamic> jsonSongs = json['songList'];


    List<Song> songs = jsonSongs
                        .map<Song>((e) => Song.fromJson(e))
                        .toList();

    print(songs.length);

    return Playlist(
      info: info,
      songs: songs
    );
  }

  get length => null;

}