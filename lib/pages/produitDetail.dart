import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:ob2a/utils/function.dart';

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
  @override
  Widget build(BuildContext context) {
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
                          height: MediaQuery.of(context).size.width < 1000
                              ? produits[0]['image'].length == 1
                                  ? 350
                                  : 400
                              : produits[0]['image'].length == 1
                                  ? 400
                                  : 500,
                          width: 450,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(),
                                  child: Obx(() => Image.network(
                                        principalImage.value,
                                        fit: BoxFit.cover,
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
                                                      e;
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
                          height: 400,
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
                                                  '\$${produits[0]['prixLivraison']}',
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
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        runAlignment:
                                            WrapAlignment.spaceBetween,
                                        children: [
                                          Obx(() => Text('\$$prixTotal',
                                              style: GoogleFonts.jost(
                                                  fontSize: 20,
                                                  color: Colors.green))),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (quantite.value <= 0)
                                                      quantite.value = 0;
                                                    else
                                                      quantite.value--;
                                                    prixTotal.value =
                                                        getPrice(produits[0]) *
                                                            quantite.value;
                                                  },
                                                  child: Icon(
                                                      Icons
                                                          .arrow_back_ios_new_outlined,
                                                      color: pColor),
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8),
                                                    child: Obx(
                                                      () => Text(
                                                          '${quantite.value}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .blue)),
                                                    )),
                                                InkWell(
                                                  onTap: () {
                                                    quantite.value++;
                                                    prixTotal.value =
                                                        getPrice(produits[0]) *
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
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: pColor,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 6, horizontal: 15),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.add_outlined,
                                                      color: Colors.white),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('Ajouter Au Panier',
                                                      style: GoogleFonts.jost(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 20))
                                                ],
                                              ),
                                            ),
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
                )
              ],
            ),
          );
        });
  }
}
