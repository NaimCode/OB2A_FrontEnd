import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as fb;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/cubit/settings_cubit.dart';
import 'package:ob2a/pages/categorie.dart';
import 'package:ob2a/pages/contact.dart';
import 'package:ob2a/pages/produitDetail.dart';
import 'package:ob2a/specialPages/connexion.dart';
import 'package:ob2a/specialPages/inscription.dart';
import 'package:ob2a/state/globalVariable.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

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
import 'package:path/path.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  setPathUrlStrategy();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorage.webStorageDirectory);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return fb.BlocProvider<SettingsCubit>(
      create: (context) => SettingsCubit(),
      child: MultiProvider(providers: [
        Provider<Authentification>(
          create: (_) => Authentification(FirebaseAuth.instance),
        ),
        // ignore: missing_required_param
        StreamProvider(
          create: (conext) => context.read<Authentification>().authStateChanges,
          initialData: null,
        ),
      ], child: MaterialApp(debugShowCheckedModeBanner: false, home: OB2A())),
    );
  }
}

class OB2A extends StatelessWidget {
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
                      child: GetMaterialApp(
                        initialRoute: '/',
                        unknownRoute: GetPage(
                            name: '/erreur404',
                            page: () => Body(content: UnknownPage())),
                        getPages: [
                          GetPage(
                              name: '/',
                              page: () => Body(content: Accueil()),
                              transition: Transition.cupertino),
                          GetPage(
                              title: 'Profil',
                              name: '/compte/:param',
                              page: () => Profil(),
                              transition: Transition.cupertino),
                          GetPage(
                              title: 'FAQ',
                              name: '/pages/faq',
                              page: () => Body(content: FAQ()),
                              transition: Transition.cupertino),
                          GetPage(
                              title: 'Contact',
                              name: '/pages/contact',
                              page: () => Body(content: Contact()),
                              transition: Transition.cupertino),
                          GetPage(
                            name: '/produit/:produit',
                            page: () => Body(content: ProduitDetail()),
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
                              page: () => Body(content: Produits()),
                              transition: Transition.cupertino),
                          GetPage(
                              name: '/produits/:slug',
                              page: () => Body(content: CategoriePage()),
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
                      ),
                    );
                  });
            }
          }),
    );
  }
}
