import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
        color: sColorLight,
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(color: sColor.withOpacity(0.4), height: 2)),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: SelectableText(
                  'FAQ',
                  style: GoogleFonts.jost(
                      fontWeight: FontWeight.w300,
                      fontSize: isMobile ? 25 : 40,
                      wordSpacing: 2),
                ),
              ),
              Expanded(
                  child: Container(color: sColor.withOpacity(0.4), height: 2)),
            ],
          ),
          Container(
            height: 600,
            child: Center(
              child: Text('Le contenu de cette page sera bientot disponible'),
            ),
          )
        ]));
  }
}
