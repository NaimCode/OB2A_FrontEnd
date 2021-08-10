import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_button/menu_button.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/data/class.dart';
import 'package:ob2a/data/internal.dart';
import 'package:ob2a/state/globalVariable.dart';
import 'package:ob2a/utils/function.dart';

import '../env.dart';

class CardProduct extends StatelessWidget {
  final e;
  final user;
  CardProduct({
    this.user,
    this.e,
    Key? key,
    required this.isMobile,
  }) : super(key: key);

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/produit/${e['slug']}');
      },
      child: Container(
        height: isMobile ? 260 : 400,
        width: isMobile ? MediaQuery.of(context).size.width / 2.1 : 280,
        padding: EdgeInsets.all(isMobile ? 7 : 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.network(
                  e['image'][0]['formats']['small']['url'] ??
                      ERROR_NETWORK_IMAGE,
                  width:
                      isMobile ? MediaQuery.of(context).size.width / 2.1 : 280,
                  fit: BoxFit.cover),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: isMobile ? 1 : 5),
                child: Text(
                  e['titre'],
                  style: GoogleFonts.jost(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: isMobile ? 1 : 2,
                )),
            e['enPromotion'] == null ||
                    e['prixPromotion'] == null ||
                    e['enPromotion'] == false
                ? SelectableText(
                    // '\$${e['prix']}'
                    getDevisePrice(
                        e['prix'], isUser(user) ? user.devise : devise.value),
                    style: GoogleFonts.jost(fontSize: 18),
                    textAlign: TextAlign.left,
                  )
                : Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SelectableText(
                        getDevisePrice(e['prix'],
                            isUser(user) ? user.devise : devise.value),
                        style: GoogleFonts.jost(
                            fontSize: 14, color: pColor.withOpacity(0.4)),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: isMobile ? 3 : 10,
                      ),
                      SelectableText(
                        getDevisePrice(e['prixPromotion'],
                            isUser(user) ? user.devise : devise.value),
                        style: GoogleFonts.jost(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: isMobile ? 3 : 10,
                      ),
                      Badge(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        toAnimate: true,
                        shape: BadgeShape.square,
                        badgeColor: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                        badgeContent: Text('promo',
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 12)),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

class CardCollection extends StatelessWidget {
  final bool isMobile;
  final e;
  const CardCollection({required this.isMobile, this.e, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/produits/${e['slug']}?type=collection');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        height: isMobile ? 150 : 200,
        width: isMobile ? double.infinity : 800,
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                child: Image.network(
                  e['image']['formats']['small']['url'] ?? ERROR_NETWORK_IMAGE,
                  fit: BoxFit.cover,
                )),
            Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    e['titre'],
                    style:
                        GoogleFonts.poppins(fontSize: 22, color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 356,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: pColor.withOpacity(0.7),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(0.6)),
                        contentPadding:
                            EdgeInsets.only(bottom: 8, left: 8, right: 8),
                        hintText: 'Recherche',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                      tooltip: 'Recherche',
                      onPressed: () {},
                      icon: Icon(Icons.search_outlined, color: pColor)),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: IconButton(
                  tooltip: 'Profile',
                  iconSize: 26,
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_outline_outlined,
                    color: pColor,
                  ))),
          IconButton(
              tooltip: 'Panier',
              onPressed: () {},
              icon: Icon(
                Icons.shopping_basket_outlined,
                color: pColor,
              ))
        ],
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Utilisateur user;

  @override
  Widget build(BuildContext _) {
    return IconButton(
        tooltip: 'Pamamètre',
        onPressed: () {
          Get.defaultDialog(
              title: 'Paramètre',
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Dévise',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      MenuButton<String>(
                        child: Container(
                          color: sColorLight,
                          width: 93,
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                    child: isUser(user)
                                        ? Text(user.devise!,
                                            overflow: TextOverflow.ellipsis)
                                        : Obx(() => Text(devise.value,
                                            overflow: TextOverflow.ellipsis))),
                                const SizedBox(
                                  width: 12,
                                  height: 17,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        items: allDevise,
                        itemBuilder: (String value) => Container(
                          height: 35,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 5),
                          child: Text(value),
                        ),
                        toggledChild: Container(
                          child: SizedBox(
                            width: 93,
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                      child: isUser(user)
                                          ? Text(user.devise!,
                                              overflow: TextOverflow.ellipsis)
                                          : Obx(() => Text(devise.value,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                  const SizedBox(
                                    width: 12,
                                    height: 17,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        onItemSelected: (String value) async {
                          if (isUser(user))
                            await FirebaseFirestore.instance
                                .collection('Utilisateur')
                                .doc(user.uid!)
                                .update({'devise': value});
                          else
                            Get.toNamed('/inscription');
                        },
                        onMenuButtonToggle: (bool isToggle) {
                          if (!isToggle) Navigator.pop(_);
                        },
                      ),
                    ],
                  ),
                ],
              ));
        },
        icon: Icon(Icons.settings_outlined));
  }
}
