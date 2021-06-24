import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:ob2a/data/class.dart';
import 'package:ob2a/responsive/desktop.dart';
import 'package:ob2a/responsive/mobile.dart';
import 'package:ob2a/utils/function.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late Utilisateur user;
  @override
  Widget build(BuildContext context) {
    user = context.watch<Utilisateur>();
    var isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        backgroundColor: sColorLight,
        title: Logo(),
        centerTitle: true,
      ),
      backgroundColor: sColorLight,
      body: Center(
        child: Container(
          width: isMobile ? MediaQuery.of(context).size.width : 800,
          child: DefaultTabController(
            initialIndex: getTabCompte(Get.parameters['param'] ?? ''),
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverPersistentHeader(
                    floating: true,
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        isScrollable: true,
                        labelColor: Colors.black87,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                              icon: Icon(Icons.person_pin_outlined),
                              text: "Informations"),
                          Tab(
                              icon: Icon(Icons.shopping_basket_outlined),
                              text: "Panier"),
                          Tab(
                              icon: Icon(Icons.local_shipping_outlined),
                              text: "Commandes"),
                          // Tab(
                          //     icon: Icon(Icons.settings_outlined),
                          //     text: "Paramètre"),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  Information(
                    user: user,
                  ),
                  Panier(
                    user: user,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Aucune commande pour l\'instant'),
                  ),
                  // Icon(Icons.directions_bike),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Information extends StatefulWidget {
  final Utilisateur user;
  const Information({required this.user, Key? key}) : super(key: key);

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                      color: pColorLight.withOpacity(0.4), height: 2)),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: SelectableText(
                  'PRINCIPAL',
                  style: GoogleFonts.jost(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      wordSpacing: 2),
                ),
              ),
              Expanded(
                  child: Container(
                      color: pColorLight.withOpacity(0.4), height: 2)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              trailing: IconButton(
                  tooltip: 'Modifier',
                  onPressed: () {},
                  icon: Icon(Icons.mode_edit_outline_outlined)),
              leading: Icon(Icons.person_outline_outlined),
              title: Text(
                widget.user.nom!,
                style: GoogleFonts.poppins(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Icon(Icons.mail_outline_outlined),
              title: Text(
                widget.user.email!,
                style: GoogleFonts.poppins(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Panier extends StatefulWidget {
  final user;
  Panier({this.user, Key? key}) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  var checkPrix = 0.0.obs;
  var checkPrixD = 0.0;

  Future<bool> rebuild(var t) async {
    if (!mounted) return false;

    // if there's a current frame,
    if (SchedulerBinding.instance!.schedulerPhase != SchedulerPhase.idle) {
      // wait for the end of that frame.
      await SchedulerBinding.instance!.endOfFrame;
      if (!mounted) return false;
    }

    checkPrix.value = t;
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 100),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.amber),
            onPressed: () {},
            child: Text('Valider',
                style: GoogleFonts.jost(fontSize: isMobile ? 20 : 25))),
      ),
      body: Container(
        padding:
            EdgeInsets.symmetric(vertical: 10, horizontal: isMobile ? 10 : 0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Utilisateur')
                .doc(widget.user.uid)
                .collection('Panier')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Chargement();
              var snap;
              var listPanier = [];
              if (snapshot.hasData) {
                snap = snapshot.data;
                for (var i in snap.docs) {
                  var produit = PanierItem.fromDoc(i);
                  // produit.getInfo();
                  listPanier.add(produit);
                }
              }
              return ListView.builder(
                  itemCount: listPanier.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<http.Response>(
                        future: http.get(Uri.parse(
                            '$API_URL/produits?id=${listPanier[index].id}')),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting)
                            return ChargementDefault();
                          var produits = [];
                          if (snap.hasData) {
                            produits = jsonDecode(snap.data!.body);
                            checkPrixD += (produits[0]['prix'] *
                                        listPanier[index].quantite) +
                                    produits[0]['prixLivraison'] ??
                                0;
                            // if (index == listPanier.length - 1) {
                            //   checkPrix.value = checkPrixD;
                            // }
                            // principalImage.value = getImageUrl(produits[0], 'large');
                            // prixTotal.value = getPrice(produits[0]) * quantite.value;
                          }
                          // return InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(
                          //         vertical: 10, horizontal: 10),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Image.network(
                          //           getImageUrlMini(produits[0], 'small'),
                          //           fit: BoxFit.fitHeight,
                          //           height: 200,
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 10),
                          //           child: Column(
                          //             children: [
                          //               Text(produits[0]['titre'],
                          //                   style: GoogleFonts.jost(
                          //                       fontSize: 20,
                          //                       fontWeight: FontWeight.bold)),
                          //               Text('\$${produits[0]['prix']}',
                          //                   style: GoogleFonts.jost(
                          //                       fontSize: 20,
                          //                       fontWeight: FontWeight.bold)),
                          //             ],
                          //           ),
                          //         ),
                          //         IconButton(
                          //             tooltip: 'Retirer',
                          //             onPressed: () async {
                          //               await FirebaseFirestore.instance
                          //                   .collection('Utilisateur')
                          //                   .doc(widget.user.uid)
                          //                   .collection('Panier')
                          //                   .doc(produits[0]['slug'])
                          //                   .delete();
                          //             },
                          //             icon: Icon(Icons.remove_circle_outline,
                          //                 color: Colors.red)),
                          //       ],
                          //     ),
                          //   ),
                          // );
                          return produits[0]['stock'] != 0
                              ? ListTile(
                                  onTap: () {
                                    Get.toNamed(
                                        '/produit/${produits[0]['slug']}');
                                  },
                                  leading: Image.network(
                                    getImageUrlMini(produits[0], 'small'),
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                  title: Text(produits[0]['titre']),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'Prix Total: \$${(produits[0]['prix'] * listPanier[index].quantite)} ${produits[0]['prixLivraison'] == null || produits[0]['prixLivraison'] == 0 ? "" : " + \$${produits[0]['prixLivraison']}"} '),
                                      Text(
                                          'Quantité: ${listPanier[index].quantite}'),
                                    ],
                                  ),
                                  trailing: IconButton(
                                      tooltip: 'Retirer',
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('Utilisateur')
                                            .doc(widget.user.uid)
                                            .collection('Panier')
                                            .doc(produits[0]['slug'])
                                            .delete();
                                      },
                                      icon: Icon(Icons.remove_circle_outline,
                                          color: Colors.red)))
                              : ListTile(
                                  onTap: () {
                                    Get.toNamed(
                                        '/produit/${produits[0]['slug']}');
                                  },
                                  tileColor: Colors.black38,
                                  leading: Image.network(
                                    getImageUrlMini(produits[0], 'small'),
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                  title: Text('En rupture de stock',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20)),
                                  trailing: IconButton(
                                      tooltip: 'Retirer',
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('Utilisateur')
                                            .doc(widget.user.uid)
                                            .collection('Panier')
                                            .doc(produits[0]['slug'])
                                            .delete();
                                      },
                                      icon: Icon(Icons.remove_circle_outline,
                                          color: Colors.red)));
                        });
                  });
            }),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: sColorLight,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
// MaterialApp(
//       home: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: TabBar(
//               tabs: [
//                 Tab(icon: Icon(Icons.directions_car)),
//                 Tab(icon: Icon(Icons.directions_transit)),
//                 Tab(icon: Icon(Icons.directions_bike)),
//               ],
//             ),
//             title: Text('Tabs Demo'),
//           ),
//           body: TabBarView(
//             children: [
//               Icon(Icons.directions_car),
//               Icon(Icons.directions_transit),
//               Icon(Icons.directions_bike),
//             ],
//           ),
//         ),
//       ),
//     );
