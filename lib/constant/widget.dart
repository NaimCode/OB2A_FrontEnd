import 'package:badges/badges.dart';
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
        height: isMobile ? 300 : 400,
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
            e['enPromotion'] == null ||
                    e['prixPromotion'] == null ||
                    e['enPromotion'] == false
                ? SelectableText(
                    '\$${e['prix']}',
                    style: GoogleFonts.jost(fontSize: 18),
                    textAlign: TextAlign.left,
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SelectableText(
                        '\$${e['prix']}',
                        style: GoogleFonts.jost(
                            fontSize: 14, color: pColor.withOpacity(0.4)),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SelectableText(
                        '\$${e['prixPromotion']}',
                        style: GoogleFonts.jost(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Badge(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        toAnimate: true,
                        shape: BadgeShape.square,
                        badgeColor: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                        badgeContent: Text('promo',
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 12)),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
