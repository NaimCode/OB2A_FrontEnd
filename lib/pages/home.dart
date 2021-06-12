import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/widget.dart';

import '../body.dart';

class SectionNewProduct extends StatelessWidget {
  const SectionNewProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                          color: pColorLight.withOpacity(0.4), height: 1)),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: SelectableText(
                      'NOUVEAUX PRODUITS',
                      style: GoogleFonts.jost(
                          fontWeight: FontWeight.w300,
                          fontSize: isMobile ? 25 : 40,
                          wordSpacing: 2),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          color: pColorLight.withOpacity(0.4), height: 1)),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Wrap(
                children: produits
                    .map((e) => CardProduct(isMobile: isMobile, e: e))
                    .toList(),
              ),
            ]));
  }
}
