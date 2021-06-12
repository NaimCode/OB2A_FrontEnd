import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/data/internal.dart';
import 'package:http/http.dart' as http;
import 'constant/miniWidget.dart';
import 'constant/widget.dart';

class Body extends StatefulWidget {
  final content;
  Body({Key? key, this.content}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List produits = [];
  var futureGetProducts;
  getProducts() async {
    var url = Uri.parse('https://ob2a.herokuapp.com/produits?_limit=8');
    var response = await http.get(url);
    produits = jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
        body: CustomScrollView(
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
                        children: MenuPrincipal.map((e) => MenuPrincipalElement(
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
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: pColor.withOpacity(0.7),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.grey.withOpacity(0.6)),
                                        contentPadding: EdgeInsets.only(
                                            bottom: 8, left: 8, right: 8),
                                        hintText: 'Recherche',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      tooltip: 'Recherche',
                                      onPressed: () {},
                                      icon: Icon(Icons.search_outlined,
                                          color: pColor)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
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
        SliverList(delegate: SliverChildListDelegate([widget.content]))
      ],
    ));
  }
}
