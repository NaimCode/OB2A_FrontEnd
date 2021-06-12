import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:ob2a/constant/widget.dart';
import 'package:ob2a/data/internal.dart';

import '../env.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SectionCategorie(),
          SectionNewProduct(),
          SectionPromoProduct(),
          SectionCollection()
        ],
      ),
    );
  }
}

class SectionCategorie extends StatelessWidget {
  const SectionCategorie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
        color: Colors.white,
        padding:
            EdgeInsets.symmetric(vertical: 30, horizontal: isMobile ? 8 : 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                          color: pColorLight.withOpacity(0.4), height: 2)),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: SelectableText(
                      'TENDANCE',
                      style: GoogleFonts.jost(
                          fontWeight: FontWeight.w300,
                          fontSize: isMobile ? 25 : 40,
                          wordSpacing: 2),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          color: pColorLight.withOpacity(0.4), height: 2)),
                ],
              ),
              isMobile
                  ? ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: CategorieHome.map(
                        (e) => InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: isMobile ? 4 : 20,
                                horizontal: isMobile ? 8 : 30),
                            padding: EdgeInsets.only(
                              bottom: 15,
                            ),
                            height: isMobile ? 400 : 460,
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                      color: sColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  width: double.infinity,
                                  child: Image.asset('${e['image']}',
                                      fit: BoxFit.cover),
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text('${e['titre']}',
                                      style: GoogleFonts.jost(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w300)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ).toList(),
                    )
                  : Row(
                      children: CategorieHome.map(
                        (e) => Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: isMobile ? 0 : 50),
                            padding: EdgeInsets.only(
                              bottom: 20,
                            ),
                            height: isMobile ? 350 : 500,
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Container(
                                    color: sColor,
                                    width: double.infinity,
                                    child: Image.asset('${e['image']}',
                                        fit: BoxFit.cover),
                                  )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Text('${e['titre']}',
                                        style: GoogleFonts.jost(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w300)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ).toList(),
                    ),
            ]));
  }
}

class SectionNewProduct extends StatefulWidget {
  const SectionNewProduct({Key? key}) : super(key: key);

  @override
  _SectionNewProductState createState() => _SectionNewProductState();
}

class _SectionNewProductState extends State<SectionNewProduct> {
  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return FutureBuilder<http.Response>(
        future: http.get(Uri.parse('$API_URL/produits?_limit=8')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container(height: 400, child: ChargementDefault());
          var produits = [];
          if (snapshot.hasData) {
            produits = jsonDecode(snapshot.data!.body);
          }
          return Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                  vertical: 30, horizontal: isMobile ? 8 : 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                                color: pColorLight.withOpacity(0.4),
                                height: 2)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 8),
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
                                color: pColorLight.withOpacity(0.4),
                                height: 2)),
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
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 30),
                    //   color: sColor,
                    //   height: 3,
                    //   width: double.infinity,
                    // )
                  ]));
        });
  }
}

class SectionPromoProduct extends StatefulWidget {
  const SectionPromoProduct({Key? key}) : super(key: key);

  @override
  _SectionPromoProductState createState() => _SectionPromoProductState();
}

class _SectionPromoProductState extends State<SectionPromoProduct> {
  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return FutureBuilder<http.Response>(
        future:
            http.get(Uri.parse('$API_URL/produits?_limit=8&enPromotion=true')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container(height: 400, child: ChargementDefault());
          var produits = [];
          if (snapshot.hasData) {
            produits = jsonDecode(snapshot.data!.body);
          }
          return Container(
              color: sColor,
              padding: EdgeInsets.symmetric(
                  vertical: 30, horizontal: isMobile ? 8 : 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                                color: pColorLight.withOpacity(0.4),
                                height: 2)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 8),
                          child: SelectableText(
                            'PRODUITS EN PROMO',
                            style: GoogleFonts.jost(
                                fontWeight: FontWeight.w300,
                                fontSize: isMobile ? 25 : 40,
                                wordSpacing: 2),
                          ),
                        ),
                        Expanded(
                            child: Container(
                                color: pColorLight.withOpacity(0.4),
                                height: 2)),
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
        });
  }
}

class SectionCollection extends StatelessWidget {
  const SectionCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return FutureBuilder<http.Response>(
        future: http.get(Uri.parse('$API_URL/collections')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container(height: 400, child: ChargementDefault());
          var collections = [];
          if (snapshot.hasData) {
            collections = jsonDecode(snapshot.data!.body);
          }
          return Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                  vertical: 30, horizontal: isMobile ? 8 : 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                                color: pColorLight.withOpacity(0.4),
                                height: 2)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 8),
                          child: SelectableText(
                            'COLLECTIONS',
                            style: GoogleFonts.jost(
                                fontWeight: FontWeight.w300,
                                fontSize: isMobile ? 25 : 40,
                                wordSpacing: 2),
                          ),
                        ),
                        Expanded(
                            child: Container(
                                color: pColorLight.withOpacity(0.4),
                                height: 2)),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Wrap(
                      children: collections
                          .map((e) => CardCollection(isMobile: isMobile, e: e))
                          .toList(),
                    ),
                  ]));
        });
  }
}
