import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

class CategoriePage extends StatefulWidget {
  const CategoriePage({Key? key}) : super(key: key);

  @override
  _CategoriePageState createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
        future: http.get(Uri.parse(
            '$API_URL/categories?slug=${Get.parameters['cat'].toString()}')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container(
                height: MediaQuery.of(context).size.height,
                child: ChargementDefault());
          var e;
          if (snapshot.hasData) {
            print(snapshot.data!.body);
            e = jsonDecode(snapshot.data!.body);
          }
          return Container(
            child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                            width: double.infinity,
                            child: Image.network(
                              e[0]['image']['formats']['large']['url'] ??
                                  ERROR_NETWORK_IMAGE,
                              fit: BoxFit.cover,
                            )),
                        Container(
                            color: Colors.black.withOpacity(0.5),
                            child: Center(
                              child: Text(
                                e[0]['titre'],
                                style: GoogleFonts.poppins(
                                    fontSize: 22, color: Colors.white),
                              ),
                            ))
                      ],
                    ),
                  )
                ]),
          );
        });
  }
}
