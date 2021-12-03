class Song {

  const Song({ required this.url, required this.id, required this.name, 
          required this.albumImage, required this.artists });

  final String url;
  final String id;
  final String name;
  final String albumImage;
  final String artists;
  
  factory Song.fromJson(Map<String, dynamic> json){
    // List artist = json['artist'] as List;
    String artists = json.containsKey('artists') ? json['artists'].join(', ') : '';
    return Song(
      url: json['url'],
      id: json['id'],
      name: json['name'],
      albumImage: json['album_image'],
      artists: artists
    );
  }

}