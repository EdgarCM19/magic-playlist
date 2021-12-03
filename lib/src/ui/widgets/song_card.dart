import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SongCard extends StatelessWidget {
  const SongCard({Key? key, required this.id, required this.img, required this.title, required this.artist}) : super(key: key);
  
  final String id;
  final String img;
  final String title;
  final String artist;

  @override
  Widget build(BuildContext context) {

    var _width = MediaQuery.of(context).size.width - (42 * 2);

    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      width: _width,
      height: 100,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), topLeft: Radius.circular(16)),
            child: Image.network(img, width: 100, height: 100, fit: BoxFit.fitWidth,)
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
                    padding: const EdgeInsets.only(left: 16.0),
                    color: Colors.black.withOpacity(0.3), 
                    // alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title, 
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.comfortaa(
                            fontSize: 18, 
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold)
                        ),
                        Text(
                          artist,
                          style: GoogleFonts.comfortaa(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.normal
                          )
                        )
                      ],
                    ),
                    width: _width - 100,
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