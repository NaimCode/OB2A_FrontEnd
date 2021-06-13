import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ob2a/pages/categorie.dart';

import 'body.dart';
import 'pages/home.dart';
import 'pages/produits.dart';
import 'pages/unknown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      unknownRoute:
          GetPage(name: '/erreur404', page: () => Body(content: UnknownPage())),
      getPages: [
        GetPage(
            name: '/',
            page: () => Body(content: Accueil()),
            transition: Transition.cupertino),
        GetPage(
            name: '/produit',
            page: () => Body(content: Produits()),
            transition: Transition.cupertino),
        GetPage(
            name: '/produits/:slug',
            page: () => Body(content: CategoriePage()),
            transition: Transition.cupertino),
      ],
      title: 'O\'B2A',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
