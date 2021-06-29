import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color sColor = Color(0xffe5e1dc);
Color sColorLight = Color(0xfffcfcfc);
Color sColorStrong = Color(0xfff9f2e3);
Color pColor = Color(0xff664b62);
Color pColorLight = Color(0xff76777c);
Color primary = Colors.white;
Color secondary = Color(0xffF79F79);
Color textColor = Colors.black;
Color accent = Color(0xff332E3C);

ThemeData light = ThemeData.light().copyWith(
    primaryColor: secondary,
    backgroundColor: primary,
    hoverColor: secondary.withOpacity(0.2),
    splashColor: secondary,
    accentColor: accent,
    highlightColor: secondary.withOpacity(0.2),
    focusColor: secondary.withOpacity(0.2),
    textTheme: TextTheme(
      headline1: GoogleFonts.jost(
          color: textColor, fontSize: 70, fontWeight: FontWeight.bold),
      headline2: GoogleFonts.jost(fontSize: 60, fontWeight: FontWeight.w600),
      headline3: GoogleFonts.jost(fontSize: 45, fontWeight: FontWeight.w300),
      headline5: GoogleFonts.jost(
          fontSize: 25,
          fontWeight: FontWeight.w300,
          color: textColor.withOpacity(0.7)),
      bodyText1: GoogleFonts.roboto(
        fontSize: 20,
        color: textColor.withOpacity(0.7),
      ),
      bodyText2: GoogleFonts.roboto(
        fontSize: 16,
        color: textColor.withOpacity(0.8),
      ),
      caption:
          GoogleFonts.roboto(fontSize: 14, color: textColor.withOpacity(0.5)),
      button: GoogleFonts.jost(fontSize: 25, fontWeight: FontWeight.normal),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: secondary,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30))),
    buttonColor: secondary,
    appBarTheme: AppBarTheme(
        backgroundColor: secondary,
        iconTheme: IconThemeData(color: textColor, size: 30)));

/////DARK//////////////////////
Color dprimary = Colors.white;
Color dsecondary = Color(0xffF79F79);
Color dtextColor = Colors.white;
Color daccent = Color(0xff332E3C);
ThemeData dark = ThemeData.dark().copyWith(
    textTheme: TextTheme(
        headline1: GoogleFonts.jost(
            fontSize: 70, fontWeight: FontWeight.bold, color: dprimary)),
    appBarTheme: AppBarTheme(
        //backgroundColor: secondary,
        // iconTheme: IconThemeData(color: textColor, size: 30)
        ));
