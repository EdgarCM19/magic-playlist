import 'package:flutter/material.dart';
import 'package:magic_playlist_app/src/ui/pages/playlist_details_screen.dart';
import 'package:magic_playlist_app/src/ui/widgets/list_card.dart';

class PlaylistList extends StatelessWidget {
  const PlaylistList({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => 
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PlaylistDetailsScreen(id: data[index].id))
              ),
              child: ListCard(
                id: data[index].id,
                img: data[index].image,
                title: data[index].name
              )
            )
        ),
    );
  }
}