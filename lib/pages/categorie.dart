import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:http/http.dart' as http;
import 'package:ob2a/constant/widget.dart';
import 'package:ob2a/data/class.dart';
import 'package:provider/provider.dart';
import 'package:ob2a/utils/function.dart';
import '../env.dart';

class CategoriePage extends StatefulWidget {
  const CategoriePage({Key? key}) : super(key: key);

  @override
  _CategoriePageState createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  late Utilisateur user;
  @override
  Widget build(BuildContext context) {
    user = context.watch<Utilisateur>();
    var isMobile = MediaQuery.of(context).size.width < 800;
    return FutureBuilder<http.Response>(
        future: http.get(Uri.parse('$API_URL${getTypeRoute(Get.parameters)}')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container(
                height: MediaQuery.of(context).size.height,
                child: ChargementDefault());
          var categorie;
          if (snapshot.hasData) {
            categorie = json.decode(snapshot.data!.body);
          }
          return Container(
            child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    height: isMobile ? 230 : 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                            height: isMobile ? 230 : 300,
                            width: double.infinity,
                            child: Image.network(
                              getImageUrl(categorie[0], 'medium'),
                              fit: BoxFit.cover,
                            )),
                        Container(
                            color: Colors.black.withOpacity(0.5),
                            child: Center(
                              child: Text(
                                categorie[0]['titre'],
                                style: GoogleFonts.jost(
                                    fontWeight: FontWeight.w200,
                                    fontSize: isMobile ? 30 : 50,
                                    color: Colors.white),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: 30, horizontal: isMobile ? 8 : 20),
                    child: Center(
                      child: categorie[0]['produits'].length == 0
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Text(
                                  'Pas encore de produit pour cette catégorie',
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey[400])),
                            )
                          : Wrap(
                              children: categorie[0]['produits']
                                  .map((e) => CardProduct(
                                        isMobile: isMobile,
                                        e: e,
                                        user: user,
                                      ))
                                  .toList()
                                  .cast<Widget>(),
                            ),
                    ),
                  )
                ]),
          );
        });
  }
}
