import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

class Utilisateur {
  String? uid;
  String? nom;
  String? email;
  String? password;
  String? image;
  List commande = [];
  List panier = [];
  bool? admin;

  String? boutique;

  Utilisateur.fromMap(Map<String, dynamic> data) {
    nom = data['nom'];
    uid = data['uid'];

    image = data['image'];
    email = data['email'];
    password = data['password'];
    boutique = data['boutique'];
    admin = data['admin'];
  }
  Utilisateur.fromDoc(var data) {
    nom = data['nom'];
    uid = data['uid'];

    image = data['image'];
    email = data['email'];
    password = data['password'];
    boutique = data['boutique'];
    admin = data['admin'];
  }
  Utilisateur(
      {this.uid,
      this.nom,
      this.boutique,
      this.password,
      this.email,
      this.image,
      this.admin});
}

class PanierItem {
  late int quantite;

  late int id;
  late var produit;
  Timestamp? date;
  PanierItem.fromDoc(var data) {
    id = data['produitId'];
    date = data['date'];
    quantite = data['quantite'];
  }
  // getInfo() async {
  //   var response =
  //       await http.get(Uri.parse('$API_URL/produits/${id.toString()}'));
  //   var produits = jsonDecode(response.body);
  //   print(produits[0]);
  //   produit = produits[0];
  // }
}
