import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:ob2a/data/class.dart';
import 'package:ob2a/data/internal.dart';
import 'package:ob2a/state/globalVariable.dart';
import 'package:ob2a/utils/function.dart';
import 'package:provider/provider.dart';

class WebAppBar extends StatefulWidget {
  WebAppBar({
    Key? key,
  }) : super(key: key);

  @override
  _WebAppBarState createState() => _WebAppBarState();
}

class _WebAppBarState extends State<WebAppBar> {
  Utilisateur? user;
  @override
  Widget build(BuildContext context) {
    user = context.watch<Utilisateur?>();
    // var isMobile = MediaQuery.of(context).size.width < 800;
    return Theme(
      data: ThemeData(primaryIconTheme: IconThemeData(color: pColor)),
      child: SliverAppBar(
        leading: Get.currentRoute == '/'
            ? Center()
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                )),
        backgroundColor: sColorLight,
        foregroundColor: pColor,
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Logo(),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: MenuPrincipal.map((e) => MenuPrincipalElement(
                      menu: e,
                    )).toList(),
              ),
            ),
            Container(
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
                              controller: search,
                              onFieldSubmitted: (s) {
                                onSearched(search.text);
                              },
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.6)),
                                contentPadding: EdgeInsets.only(
                                    bottom: 8, left: 8, right: 8),
                                hintText: 'Recherche',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                              tooltip: 'Recherche',
                              onPressed: () {
                                onSearched(search.text);
                              },
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
                          onPressed: () {
                            if (isUser(user))
                              Get.toNamed('/prodfile');
                            else
                              Get.toNamed('/connexion');
                          },
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
            )
          ],
        )),
        pinned: true,
      ),
    );
  }
}
