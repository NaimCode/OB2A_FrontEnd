import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:ob2a/data/class.dart';
import 'package:ob2a/utils/function.dart';
import 'package:provider/provider.dart';
import '../env.dart';

class ProduitDetail extends StatefulWidget {
  const ProduitDetail({Key? key}) : super(key: key);

  @override
  _ProduitDetailState createState() => _ProduitDetailState();
}

class _ProduitDetailState extends State<ProduitDetail> {
  var principalImage = ''.obs;
  var prixTotal = 0.0.obs;
  var quantite = 1.obs;
  Utilisateur? user;
  bool isChargingPanier = false;
  @override
  Widget build(BuildContext context) {
    user = context.watch<Utilisateur?>();
    for (var i = 0; i < user!.panier.length; i++) print(i.toString());
    var isMobile = MediaQuery.of(context).size.width < 800;
    return FutureBuilder<http.Response>(
        future: http.get(
            Uri.parse('$API_URL/produits?slug=${Get.parameters['produit']}')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container(height: 600, child: ChargementDefault());
          var produits = [];
          if (snapshot.hasData) {
            produits = jsonDecode(snapshot.data!.body);
            principalImage.value = getImageUrl(produits[0], 'large');
            prixTotal.value = getPrice(produits[0]) * quantite.value;
          }
          return Container(
            color: sColorLight,
            padding: EdgeInsets.symmetric(
                vertical: 20, horizontal: isMobile ? 10 : 50),
            child: ListView(
              physics: isMobile ? NeverScrollableScrollPhysics() : null,
              shrinkWrap: true,
              children: [
                Container(
                  child: Center(
                    child: Wrap(
                      runSpacing: isMobile ? 0 : 20,
                      spacing: isMobile ? 0 : 20,
                      children: [
                        Container(
                          height: isMobile ? 400 : 500,
                          width: 450,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              produits[0]['image'].length == 1
                                  ? Expanded(
                                      child: Container(
                                        width: 450,
                                        height: isMobile ? 400 : 500,
                                        padding: EdgeInsets.symmetric(),
                                        child: Obx(() => Image.network(
                                            principalImage.value,
                                            fit: BoxFit.fitHeight)),
                                      ),
                                    )
                                  : Expanded(
                                      child: Container(
                                        width: 450,
                                        padding: EdgeInsets.symmetric(),
                                        child: Obx(() => Image.network(
                                              principalImage.value,
                                              fit: BoxFit.fitHeight,
                                            )),
                                      ),
                                    ),
                              produits[0]['image'].length == 1
                                  ? Container()
                                  : SingleChildScrollView(
                                      child: Row(
                                        children: produits[0]['image']
                                            .map((e) => Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  height: 80,
                                                  width: 120,
                                                  child: InkWell(
                                                    onTap: () {
                                                      principalImage
                                                          .value = e['formats']
                                                                  ['small']
                                                              ['url'] ??
                                                          ERROR_NETWORK_IMAGE;
                                                    },
                                                    child: Image.network(
                                                      '${e['formats']['small']['url'] ?? ERROR_NETWORK_IMAGE}',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ))
                                            .toList()
                                            .cast<Widget>(),
                                      ),
                                    )
                            ],
                          ),
                        ),
                        Container(
                          height: 500,
                          width: 450,
                          margin: EdgeInsets.symmetric(
                              horizontal: isMobile ? 0 : 30),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                produits[0]['titre'],
                                style: GoogleFonts.jost(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 30,
                                    color: pColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              produits[0]['enPromotion'] == null ||
                                      produits[0]['prixPromotion'] == null ||
                                      produits[0]['enPromotion'] == false
                                  ? SelectableText(
                                      '\$${produits[0]['prix']}',
                                      style: GoogleFonts.jost(fontSize: 25),
                                      textAlign: TextAlign.left,
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SelectableText(
                                          '\$${produits[0]['prix']}',
                                          style: GoogleFonts.jost(
                                              fontSize: 25,
                                              color: pColor.withOpacity(0.4)),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SelectableText(
                                          '\$${produits[0]['prixPromotion']}',
                                          style: GoogleFonts.jost(fontSize: 25),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              produits[0]['taille'] == null
                                  ? Container()
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Divider(
                                          color: pColor,
                                          thickness: 1,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SelectableText('Taille',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: pColor)),
                                              SelectableText(
                                                  produits[0]['taille'],
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              produits[0]['couleur'] == null
                                  ? Container()
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Divider(
                                          color: pColor,
                                          thickness: 1,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SelectableText('Couleur',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: pColor)),
                                              SelectableText(
                                                  produits[0]['couleur'],
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              produits[0]['stock'] == null
                                  ? Container()
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Divider(
                                          color: pColor,
                                          thickness: 1,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SelectableText('Stock',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: pColor)),
                                              SelectableText(
                                                  produits[0]['stock'] <= 0
                                                      ? 'Rupture'
                                                      : 'Disponible',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: produits[0]
                                                                  ['stock'] <=
                                                              0
                                                          ? Colors.red
                                                          : Colors.blue)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              produits[0]['prixLivraison'] == null &&
                                      produits[0]['enPromotion'] == false
                                  ? Container()
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Divider(
                                          color: pColor,
                                          thickness: 1,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SelectableText('Expédition',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: pColor)),
                                              SelectableText(
                                                  produits[0]['prixLivraison'] ==
                                                          0
                                                      ? 'Gratuit'
                                                      : '\$${produits[0]['prixLivraison']}',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              Expanded(
                                child: Container(
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: pColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text('Total :',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 22,
                                                        color: pColor)),
                                                Obx(() => Text(
                                                    '\$${prixTotal.toStringAsFixed(2)}',
                                                    style: GoogleFonts.jost(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 30,
                                                        color: Colors.green))),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        if (quantite.value <= 0)
                                                          quantite.value = 0;
                                                        else
                                                          quantite.value--;
                                                        prixTotal
                                                            .value = getPrice(
                                                                produits[0]) *
                                                            quantite.value;
                                                      },
                                                      child: Icon(
                                                          Icons
                                                              .arrow_back_ios_new_outlined,
                                                          color: pColor),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8),
                                                        child: Obx(
                                                          () => Text(
                                                              '${quantite.value}',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .blue)),
                                                        )),
                                                    InkWell(
                                                      onTap: () {
                                                        quantite.value++;
                                                        prixTotal
                                                            .value = getPrice(
                                                                produits[0]) *
                                                            quantite.value;
                                                      },
                                                      child: Icon(
                                                          Icons
                                                              .arrow_forward_ios_outlined,
                                                          color: pColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              isExist(user!.panier,
                                                      produits[0]['id'])
                                                  ? InkWell(
                                                      onTap: () async {
                                                        isChargingPanier = true;
                                                        var panier =
                                                            user!.panier;

                                                        panier.remove(
                                                            produits[0]['id']
                                                                .toString());
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Utilisateur')
                                                            .doc(user!.uid)
                                                            .update({
                                                          'panier': panier
                                                        });
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    '${produits[0]['titre']} a été retiré de votre panier',
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                            color:
                                                                                Colors.red))));
                                                        isChargingPanier =
                                                            false;
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 6,
                                                                horizontal: 15),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .remove_circle_outline,
                                                                color: Colors
                                                                    .white),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                                'Retirer Du Panier',
                                                                style: GoogleFonts.jost(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        20))
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () async {
                                                        if (user!.uid ==
                                                            'Anonyme') {
                                                          Get.toNamed(
                                                              '/inscription');
                                                        } else {
                                                          isChargingPanier =
                                                              true;

                                                          user!.panier.add(
                                                              produits[0]['id']
                                                                  .toString());
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Utilisateur')
                                                              .doc(user!.uid)
                                                              .update({
                                                            'panier':
                                                                user!.panier
                                                          });
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      '${produits[0]['titre']} a été ajouté à votre panier',
                                                                      style: GoogleFonts.roboto(
                                                                          color:
                                                                              Colors.white))));
                                                          isChargingPanier =
                                                              false;
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 6,
                                                                horizontal: 15),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .add_outlined,
                                                                color: Colors
                                                                    .white),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                                'Ajouter Au Panier',
                                                                style: GoogleFonts.jost(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        20))
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: produits[0]['description'] == null
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Container(
                                width: 1000,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Text('${produits[0]['description']}',
                                    style: GoogleFonts.jost(
                                        wordSpacing: 2, fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                )
              ],
            ),
          );
        });
  }
}