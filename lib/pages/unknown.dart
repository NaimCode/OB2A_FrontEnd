import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text(
          'La page que vous chercher est introuvable',
          style: GoogleFonts.poppins(
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
