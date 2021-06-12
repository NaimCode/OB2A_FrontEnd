import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/data/internal.dart';
import 'package:http/http.dart' as http;
import 'constant/miniWidget.dart';
import 'constant/widget.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List produits = [];
  var futureGetProducts;
  getProducts() async {
    var url = Uri.parse('https://ob2a.herokuapp.com/produits');
    var response = await http.get(url);
    produits = jsonDecode(response.body);
    print(produits);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
        body: FutureBuilder(
            future: getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: Text('waitting'));
              return CustomScrollView(
                slivers: [
                  isMobile
                      ? SliverAppBar()
                      : SliverAppBar(
                          backgroundColor: sColorLight,
                          title: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Logo(),
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: MenuPrincipal.map(
                                      (e) => MenuPrincipalElement(
                                            menu: e,
                                          )).toList(),
                                ),
                              ),
                              Container(
                                width: 356,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: pColor.withOpacity(0.7),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey
                                                          .withOpacity(0.6)),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 8,
                                                          left: 8,
                                                          right: 8),
                                                  hintText: 'Recherche',
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                                tooltip: 'Recherche',
                                                onPressed: () {},
                                                icon: Icon(
                                                    Icons.search_outlined,
                                                    color: pColor)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 3),
                                        child: IconButton(
                                            tooltip: 'Profile',
                                            iconSize: 26,
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.person_outline_outlined,
                                              color: pColor,
                                            ))),
                                    IconButton(
                                        tooltip: 'Panier',
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.shopping_basket_outlined,
                                          color: pColor,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          )),
                          pinned: true,
                        ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    // Container(
                    //   width: double.infinity,
                    //   height: MediaQuery.of(context).size.height * 0.8,
                    //   color: sColor,
                    //   child: isMobile
                    //       ? Column(
                    //           children: _heroSection(true),
                    //         )
                    //       : Row(
                    //           children: _heroSection(false),
                    //         ),
                    // ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        child: Center(
                          child: Wrap(
                            children: produits
                                .map((e) =>
                                    CardProduct(isMobile: isMobile, e: e))
                                .toList(),
                          ),
                        )),
                  ]))
                ],
              );
            }));
  }
}

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
    return Container(
      height: isMobile ? 300 : 350,
      width: isMobile ? MediaQuery.of(context).size.width / 2.2 : 280,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Image.network(e['image'][0]['url'],
                width: 240, fit: BoxFit.cover),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                e['titre'],
                style: GoogleFonts.jost(fontSize: 18),
                maxLines: 2,
              )),
          SelectableText(
            '\$${e['prix']}',
            style: GoogleFonts.jost(fontSize: 18),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}

_heroSection(bool isMobile) {
  return [
    Expanded(
        child: Container(
      padding: EdgeInsets.all(isMobile ? 5 : 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            'LE NOUVEAU MODELE DES IWATCH SONT DISPONIBLE',
            style: GoogleFonts.jost(
              fontSize: 30.0,
            ),
            maxLines: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'acheter dès maintenant avant la rupture',
              style: TextStyle(fontSize: 18.0),
              maxLines: 1,
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text('Acheter'))
        ],
      ),
    )),
    Expanded(
      child: Container(
          child: Image.asset('images/heroImage.png', fit: BoxFit.fitHeight)),
    )
  ];
}
