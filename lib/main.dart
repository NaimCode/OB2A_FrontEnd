import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/pages/categorie.dart';
import 'package:ob2a/pages/contact.dart';
import 'package:ob2a/pages/produitDetail.dart';
import 'package:ob2a/specialPages/connexion.dart';
import 'package:ob2a/specialPages/inscription.dart';
import 'package:ob2a/state/globalVariable.dart';
import 'package:provider/provider.dart';

import 'body.dart';
import 'constant/miniWidget.dart';
import 'data/class.dart';
import 'pages/faq.dart';
import 'pages/home.dart';
import 'pages/produits.dart';
import 'pages/unknown.dart';
import 'service/authentification.dart';
import 'specialPages/compte.dart';
import 'test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<Authentification>(
            create: (_) => Authentification(FirebaseAuth.instance),
          ),
          // ignore: missing_required_param
          StreamProvider(
            create: (conext) =>
                context.read<Authentification>().authStateChanges,
            initialData: null,
          ),
        ],
        child: GetMaterialApp(
          initialRoute: '/',
          unknownRoute: GetPage(
              name: '/erreur404', page: () => Body(content: UnknownPage())),
          getPages: [
            GetPage(
                name: '/',
                page: () => OB2A(page: Body(content: Accueil())),
                transition: Transition.cupertino),
            GetPage(
                name: '/compte/:param',
                page: () => OB2A(page: Profil()),
                transition: Transition.cupertino),
            GetPage(
                name: '/pages/faq',
                page: () => OB2A(page: Body(content: FAQ())),
                transition: Transition.cupertino),
            GetPage(
                name: '/pages/contact',
                page: () => OB2A(page: Body(content: Contact())),
                transition: Transition.cupertino),
            GetPage(
              name: '/produit/:produit',
              page: () => OB2A(page: Body(content: ProduitDetail())),
            ),
            GetPage(
                name: '/connexion',
                page: () => Connexion(),
                transition: Transition.cupertinoDialog),
            GetPage(
                name: '/inscription',
                page: () => Inscription(),
                transition: Transition.cupertinoDialog),
            GetPage(
                name: '/produit',
                page: () => OB2A(page: Body(content: Produits())),
                transition: Transition.cupertino),
            GetPage(
                name: '/produits/:slug',
                page: () => OB2A(page: Body(content: CategoriePage())),
                transition: Transition.cupertino),
            GetPage(
                name: '/test',
                page: () => Test(),
                transition: Transition.cupertino),
          ],
          title: 'O\'B2A',
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class OB2A extends StatelessWidget {
  final Widget? page;
  OB2A({this.page});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<Authentification>();

    return Scaffold(
      body: StreamBuilder<User?>(
          stream: firebaseUser.authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Chargement();
            if (!snapshot.hasData) {
              firebaseUser.connection('naimzeroab@gmail.com', '123456');
              //  userObs.value = FirebaseAuth.instance.currentUser;
              return Chargement();
            } else {
              switch (Get.currentRoute) {
                case '/dashboard':
                  // Future.delayed(const Duration(milliseconds: 100), () {
                  Get.close(1);
                  Get.offNamed('/');
                  // });
                  break;
                default:
              }
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Utilisateur')
                      .doc(firebaseUser.currentUser()
                          ? "Anonyme"
                          : snapshot.data!.uid)
                      .snapshots(),
                  builder: (context, doc) {
                    if (doc.connectionState == ConnectionState.waiting)
                      return Chargement();

                    Utilisateur? userProvider;
                    if (!doc.hasData)
                      userProvider = null;
                    else {
                      var user = doc.data;
                      userProvider = Utilisateur.fromDoc(user);
                      devise.value = userProvider.devise!;
                      // userProvider = Utilisateur(
                      //     nom: user['nom'],
                      //     image: user['image'],
                      //     email: user['email'],
                      //     password: user['password'],
                      //     admin: user['admin'],
                      //     boutique: user['boutique'],
                      //     uid: user.id);

                    }

                    //  print(profile);
                    return ProxyProvider0<Utilisateur>(
                      update: (_, __) => userProvider!,
                      child: page,
                    );
                  });
            }
          }),
    );
  }
}
