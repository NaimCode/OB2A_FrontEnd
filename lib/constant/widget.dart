import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';

class MenuPrincipalElement extends StatefulWidget {
  final menu;
  MenuPrincipalElement({this.menu});

  @override
  _MenuPrincipalElementState createState() => _MenuPrincipalElementState();
}

class _MenuPrincipalElementState extends State<MenuPrincipalElement> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(widget.menu['titre'],
            style:
                GoogleFonts.jost(color: pColor.withOpacity(0.8), fontSize: 18)),
      ),
    );
  }
}
