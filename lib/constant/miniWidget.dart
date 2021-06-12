import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('O\'B2A',
        style: GoogleFonts.jost(
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: Colors.grey[800],
            fontSize: 30));

    //   Text('O\'B2A',
  }
}
