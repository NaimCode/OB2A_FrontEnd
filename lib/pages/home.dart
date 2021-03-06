import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:ob2a/constant/widget.dart';
import 'package:ob2a/data/class.dart';
import 'package:ob2a/data/internal.dart';
import 'package:provider/provider.dart';
import '../env.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  late Utilisateur user;
  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    user = context.watch<Utilisateur>();
    return Container(
      child: ListView(
        physics: isMobile ? NeverScrollableScrollPhysics() : null,
        shrinkWrap: true,
        children: [
          Landing(key: ValueKey<int>(1)),
          SectionCategorie(key: ValueKey<int>(2)),
          SectionNewProduct(user: user, key: ValueKey<int>(3)),
          SectionPromoProduct(user: user, key: ValueKey<int>(4)),
          SectionCollection(key: ValueKey<int>(5))
        ],
      ),
    );
  }
}

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
        child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: sColorLight,
                //   gradient: LinearGradient(
                // begin: Alignment.bottomCenter,
                // end: Alignment.topCenter,
                // colors: [Colors.transparent, sColorLight],
                // )
              ),
              height:
                  isMobile ? null : MediaQuery.of(context).size.height * 0.7,
              child: Wrap(
                children: [
                  Container(
                    height: isMobile
                        ? null
                        : MediaQuery.of(context).size.height * (0.7),
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 50,
                      vertical: isMobile ? 40 : 0,
                    ),
                    width: isMobile
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NOUVELLE EDITION NIKE 2021',
                          style: GoogleFonts.jost(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.left,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Acheter d??s maintenant avant la rupture du stock',
                          style: GoogleFonts.jost(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: pColorLight),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.left,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: pColor),
                            onPressed: () {
                              Get.toNamed('/produit/basket-homme-rouge');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Acheter',
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.w200,
                                      color: Colors.white,
                                      fontSize: 25)),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: isMobile
                        ? null
                        : MediaQuery.of(context).size.height * (0.7),
                    width: isMobile
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset(
                      'images/heroImage.png',
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

class SectionCategorie extends StatefulWidget {
  const SectionCategorie({Key? key}) : super(key: key);

  @override
  _SectionCategorieState createState() => _SectionCategorieState();
}

class _SectionCategorieState extends State<SectionCategorie> {
  bool _animate = false;
  static bool _isStart = true;
  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: 300), () {
            setState(() {
              _animate = true;
              // _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;

    return AnimatedOpacity(
        duration: Duration(milliseconds: 1300),
        opacity: _animate ? 1 : 0,
        curve: Curves.elasticOut,
        child: AnimatedPadding(
            duration: Duration(milliseconds: 1300),
            padding: _animate
                ? const EdgeInsets.all(4.0)
                : const EdgeInsets.only(top: 10),
            child: Container(
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
                              'TENDANCE',
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
                      isMobile
                          ? ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: CategorieHome.map(
                                (e) => InkWell(
                                  onTap: () {
                                    Get.toNamed('${e['route']}');
                                  },
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
                                          ),
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
                                        vertical: 20,
                                        horizontal: isMobile ? 0 : 50),
                                    padding: EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    height: isMobile ? 350 : 500,
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed('${e['route']}');
                                      },
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
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                    ]))));
  }
}

class SectionNewProduct extends StatefulWidget {
  final user;
  const SectionNewProduct({this.user, Key? key}) : super(key: key);

  @override
  _SectionNewProductState createState() => _SectionNewProductState();
}

class _SectionNewProductState extends State<SectionNewProduct> {
  bool _animate = false;
  static bool _isStart = true;
  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: 300), () {
            setState(() {
              _animate = true;
              // _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return AnimatedOpacity(
        duration: Duration(milliseconds: 1300),
        opacity: _animate ? 1 : 0,
        curve: Curves.elasticOut,
        child: FutureBuilder<http.Response>(
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
                              .map((e) => CardProduct(
                                    isMobile: isMobile,
                                    e: e,
                                    user: widget.user,
                                  ))
                              .toList(),
                        ),
                        // Container(
                        //   margin: EdgeInsets.symmetric(vertical: 30),
                        //   color: sColor,
                        //   height: 3,
                        //   width: double.infinity,
                        // )
                      ]));
            }));
  }
}

class SectionPromoProduct extends StatefulWidget {
  final user;
  const SectionPromoProduct({this.user, Key? key}) : super(key: key);

  @override
  _SectionPromoProductState createState() => _SectionPromoProductState();
}

class _SectionPromoProductState extends State<SectionPromoProduct> {
  bool _animate = false;
  static bool _isStart = true;
  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: 300), () {
            setState(() {
              _animate = true;
              // _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return AnimatedOpacity(
        duration: Duration(milliseconds: 1300),
        opacity: _animate ? 1 : 0,
        curve: Curves.elasticOut,
        child: FutureBuilder<http.Response>(
            future: http
                .get(Uri.parse('$API_URL/produits?_limit=8&enPromotion=true')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Container(height: 600, child: ChargementDefault());
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
                              .map((e) => CardProduct(
                                    isMobile: isMobile,
                                    e: e,
                                    user: widget.user,
                                  ))
                              .toList(),
                        ),
                      ]));
            }));
  }
}

class SectionCollection extends StatefulWidget {
  const SectionCollection({Key? key}) : super(key: key);

  @override
  _SectionCollectionState createState() => _SectionCollectionState();
}

class _SectionCollectionState extends State<SectionCollection> {
  bool _animate = false;
  static bool _isStart = true;
  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: 300), () {
            setState(() {
              _animate = true;
              // _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return AnimatedOpacity(
        duration: Duration(milliseconds: 1300),
        opacity: _animate ? 1 : 0,
        curve: Curves.elasticOut,
        child: AnimatedPadding(
            duration: Duration(milliseconds: 1300),
            padding: _animate
                ? const EdgeInsets.all(4.0)
                : const EdgeInsets.only(top: 10),
            child: FutureBuilder<http.Response>(
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
                                  .map((e) =>
                                      CardCollection(isMobile: isMobile, e: e))
                                  .toList(),
                            ),
                          ]));
                })));
  }
}
