import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:ob2a/constant/widget.dart';
import 'package:ob2a/utils/function.dart';

import '../env.dart';

class Produits extends StatefulWidget {
  const Produits({Key? key}) : super(key: key);

  @override
  _ProduitsState createState() => _ProduitsState();
}

class _ProduitsState extends State<Produits> {
  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return FutureBuilder<http.Response>(
        future: http
            .get(Uri.parse('$API_URL/produits${getQueryUrl(Get.parameters)}')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container(height: 600, child: ChargementDefault());
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
                    isMobile
                        ? SelectableText(
                            getTitle('${Get.parameters['query']}',
                                produits.length, Get.parameters['value']),
                            style: GoogleFonts.jost(
                                fontWeight: FontWeight.w300,
                                fontSize: isMobile ? 25 : 40,
                                wordSpacing: 2),
                          )
                        : Row(
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
                                  getTitle('${Get.parameters['query']}',
                                      produits.length, Get.parameters['value']),
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
                          .toList()
                          .cast<Widget>(),
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
