import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';

class MobileAppBar extends StatefulWidget {
  MobileAppBar({
    Key? key,
  }) : super(key: key);

  @override
  _MobileAppBarState createState() => _MobileAppBarState();
}

//  Container(
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: MenuPrincipal.map((e) => MenuPrincipalElement(
//                       menu: e,
//                     )).toList(),
//               ),
//             ),

// Expanded(
//                     child: Container(
//                       height: 40,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: pColor.withOpacity(0.7),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: TextFormField(
//                               controller: search,
//                               onFieldSubmitted: (s) {
//                                 onSearched(search.text);
//                               },
//                               decoration: InputDecoration(
//                                 hintStyle: TextStyle(
//                                     color: Colors.grey.withOpacity(0.6)),
//                                 contentPadding: EdgeInsets.only(
//                                     bottom: 8, left: 8, right: 8),
//                                 hintText: 'Recherche',
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                               tooltip: 'Recherche',
//                               onPressed: () {
//                                 onSearched(search.text);
//                               },
//                               icon: Icon(Icons.search_outlined, color: pColor)),
//                         ],
//                       ),
//                     ),
//                   ),
class _MobileAppBarState extends State<MobileAppBar> {
  @override
  Widget build(BuildContext context) {
    // var isMobile = MediaQuery.of(context).size.width < 800;
    return Theme(
      data: ThemeData(primaryIconTheme: IconThemeData(color: pColor)),
      child: SliverAppBar(
        pinned: true,
        floating: true,
        snap: true,
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
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Logo(),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
            )
          ],
        )),
      ),
    );
  }
}
