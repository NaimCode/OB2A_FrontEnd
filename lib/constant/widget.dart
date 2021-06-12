import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';

class CardProduct extends StatelessWidget {
  var e;
  CardProduct({
    this.e,
    Key? key,
    required this.isMobile,
  }) : super(key: key);

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: isMobile ? 300 : 350,
        width: isMobile ? MediaQuery.of(context).size.width / 2.2 : 280,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.network(
                  e['image'][0]['formats']['small']['url'] ?? '',
                  width: 300,
                  fit: BoxFit.cover),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  e['titre'],
                  style: GoogleFonts.jost(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 2,
                )),
            SelectableText(
              '\$${e['prix']}',
              style: GoogleFonts.jost(fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
