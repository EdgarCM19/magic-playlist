import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NoLists extends StatelessWidget {
  const NoLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 64.0),
      child: Column(
        children: [
          Text('No hay listas', style: GoogleFonts.poppins(fontSize: 24, color: Theme.of(context).colorScheme.secondaryVariant),),
          const SizedBox(height: 48.0,),
          SvgPicture.asset(
            'assets/svg/no_data.svg',
            width: 256,
            height: 256,
          ),
        ],
      ),
    );
  }
}