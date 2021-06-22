import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

//import 'package:flutter_facebook_login_web/flutter_facebook_login_web.dart';

final firestoreinstance = FirebaseFirestore.instance;

//final facebookSignIn = FacebookLoginWeb();

class Authentification {
  FirebaseAuth _firebaseAuth;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Authentification(this._firebaseAuth);
  deconnection() async {
    await _firebaseAuth.signOut();
  }

  currentUser() {
    return _firebaseAuth.currentUser!.isAnonymous;
  }

  signAnonyme() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> checkEmail() async {}
  Future<String> enregistrementOnly(String mail, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      return 'Connexion réussie';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use')
        return 'Email existe déjà';
      else
        return e.code;
    }
  }

  sendVerifyEmail() {
    User? user = _firebaseAuth.currentUser;
    user!.sendEmailVerification();
  }

  deleteUser(
    String mail,
    String password,
  ) async {
    var user = await FirebaseAuth.instance.currentUser;
    try {
      await user!.delete();
    } catch (e) {
      print(e);
    }
  }

  createUser() {}
  timerFunction() {}
  enregistrementAuth(String mail, String password, String nom) async {
    try {
      // var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: mail,
      //   password: password,
      // );
      Timer timer;
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );

      await user.user!.sendEmailVerification();

      timer = Timer.periodic(Duration(seconds: 3), (timer) async {
        User? userCreditial = _firebaseAuth.currentUser;
        await userCreditial!.reload();
        if (userCreditial.emailVerified) {
          timer.cancel();
          var utilisateurs = {
            'nom': nom,
            'email': user.user!.email,
            'password': password,
            'image': null,
            'boutique': null,
            'devise': 'Euro',
            'commande': <String>[],
            'panier': <String>[],
            'souhait': <String>[],
            'admin': false,
            'uid': user.user!.uid,
          };
          await firestoreinstance
              .collection('Utilisateur')
              .doc(user.user!.uid)
              .set(utilisateurs);
        }
        Get.back();
        Get.rawSnackbar(
            title: "Inscription réussi",
            message: 'Bienvenue sur O\'B2A',
            icon: Icon(Icons.verified_user));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Le mot de passe est trop faible, minimum 6 caratères';
      } else if (e.code == 'email-already-in-use') {
        return 'Email existe déjà';
      }
    } catch (e) {
      print(e);
      return 'erreur';
    }
  }

  connection(String mail, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);
      return 'Connexion réussi, ravis de vous revoir';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'L\'Email est incorrect';
      } else if (e.code == 'wrong-password') {
        return 'Le mot de passe est incorrect';
      }
    }
  }
}
