class PlaylistInfo {

  const PlaylistInfo({ required this.id, required this.name, required this.image, required this.urlPlaylist });

  final String id;
  final String name;
  final String image;
  final String urlPlaylist;

  factory PlaylistInfo.fromJson(Map<String, dynamic> json){
    return PlaylistInfo(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      urlPlaylist: json['url_playlist']
    );
  }


  static Future<List<PlaylistInfo>> fromJsonList(List<dynamic> json) async {
    // for (var element in json) { print(element['name']); }
    return json.map((e) => PlaylistInfo.fromJson(e)).toList();
    // return [];
  }

}