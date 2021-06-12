import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';

import '../env.dart';

class CardProduct extends StatelessWidget {
  final e;
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
        height: isMobile ? 260 : 400,
        width: isMobile ? MediaQuery.of(context).size.width / 2.1 : 280,
        padding: EdgeInsets.all(isMobile ? 7 : 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.network(
                  e['image'][0]['formats']['small']['url'] ??
                      ERROR_NETWORK_IMAGE,
                  width:
                      isMobile ? MediaQuery.of(context).size.width / 2.1 : 280,
                  fit: BoxFit.cover),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: isMobile ? 1 : 5),
                child: Text(
                  e['titre'],
                  style: GoogleFonts.jost(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: isMobile ? 1 : 2,
                )),
            e['enPromotion'] == null ||
                    e['prixPromotion'] == null ||
                    e['enPromotion'] == false
                ? SelectableText(
                    '\$${e['prix']}',
                    style: GoogleFonts.jost(fontSize: 18),
                    textAlign: TextAlign.left,
                  )
                : Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SelectableText(
                        '\$${e['prix']}',
                        style: GoogleFonts.jost(
                            fontSize: 14, color: pColor.withOpacity(0.4)),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: isMobile ? 3 : 10,
                      ),
                      SelectableText(
                        '\$${e['prixPromotion']}',
                        style: GoogleFonts.jost(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: isMobile ? 3 : 10,
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

class CardCollection extends StatelessWidget {
  final bool isMobile;
  final e;
  const CardCollection({required this.isMobile, this.e, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        height: isMobile ? 150 : 200,
        width: isMobile ? double.infinity : 800,
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                child: Image.network(
                  e['image']['formats']['small']['url'] ?? ERROR_NETWORK_IMAGE,
                  fit: BoxFit.cover,
                )),
            Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    e['titre'],
                    style:
                        GoogleFonts.poppins(fontSize: 22, color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
