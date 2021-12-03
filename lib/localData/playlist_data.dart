import 'package:magic_playlist_app/src/models/playlist_info.dart';

const List<PlaylistInfo> playlistData = [
  PlaylistInfo(id: '0', name: 'Playlist 1', image: 'assets/img/img_1.jpg', urlPlaylist: ''),
  PlaylistInfo(id: '1', name: 'Playlist 2', image: 'assets/img/img_2.jpg', urlPlaylist: ''),
  PlaylistInfo(id: '2', name: 'Playlist 3', image: 'assets/img/img_3.jpg', urlPlaylist: ''),
  PlaylistInfo(id: '3', name: 'Playlist 4', image: 'assets/img/img_4.jpg', urlPlaylist: ''),
  PlaylistInfo(id: '4', name: 'Playlist 5', image: 'assets/img/img_5.jpg', urlPlaylist: ''),
];


PlaylistInfo getPlaylistById(int id){
  return playlistData[id];
}