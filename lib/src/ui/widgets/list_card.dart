import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_playlist_app/src/ui/pages/playlist_details.dart';
import 'package:magic_playlist_app/src/ui/pages/playlist_details_screen.dart';

class ListCard extends StatelessWidget {
  const ListCard({Key? key, required this.id, required this.img, required this.title } ) : super(key: key);
  
  final String id;
  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {

    var _width = MediaQuery.of(context).size.width - (42 * 2);
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),

      width: _width,
      height: 100.0,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), topLeft: Radius.circular(16)),
            child: Hero(
              tag: id,
              child: Image.network(img, height: 100, width: 100, fit: BoxFit.fitWidth,)
            )
          ),
          Stack(
            children: [
              ClipRRect(
                child: Image.network(img, width: _width - 100, height: 100, fit: BoxFit.fitWidth),
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16), topRight: Radius.circular(16)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.3), 
                    alignment: Alignment.center,
                      child: Text(
                        title, 
                        style: GoogleFonts.comfortaa(fontSize: 18, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
                        overflow: TextOverflow.clip,
                      ),
                    width: _width - 100,
                    height: 100,
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}