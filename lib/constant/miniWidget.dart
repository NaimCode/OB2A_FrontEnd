import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/data/internal.dart';

import 'color.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/');
      },
      child: Container(
        color: sColorLight,
        child: Text('O\'B2A',
            style: GoogleFonts.jost(
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                color: Colors.indigo[900],
                fontSize: 30)),
      ),
    );

    //   Text('O\'B2A',
  }
}

class MenuPrincipalElement extends StatefulWidget {
  final menu;
  MenuPrincipalElement({this.menu});

  @override
  _MenuPrincipalElementState createState() => _MenuPrincipalElementState();
}

class _MenuPrincipalElementState extends State<MenuPrincipalElement> {
  @override
  Widget build(BuildContext context) {
    switch (widget.menu['titre']) {
      case 'Catégorie':
        return PopupMenuButton(
            onSelected: (int e) {
              Get.toNamed('${CategorieItem[e.toInt()]['route']}');
            },
            tooltip: 'Choisir une catégorie',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(widget.menu['titre'],
                  style: GoogleFonts.jost(
                      color: pColor.withOpacity(0.8), fontSize: 18)),
            ),
            itemBuilder: (BuildContext context) =>
                CategorieItem.map((e) => PopupMenuItem(
                      value: CategorieItem.indexOf(e),
                      child: Text('${e['titre']}',
                          style: GoogleFonts.roboto(fontSize: 16)),
                    )).toList());
      //  const PopupMenuDivider(),
      //           const PopupMenuItem(child: Text('Item A')),
      case 'Pages':
        return PopupMenuButton(
            onSelected: (int e) {
              Get.toNamed('${PageItem[e.toInt()]['route']}');
            },
            tooltip: 'Allez vers une page',
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(widget.menu['titre'],
                  style: GoogleFonts.jost(
                      color: pColor.withOpacity(0.8), fontSize: 18)),
            ),
            itemBuilder: (BuildContext context) =>
                PageItem.map((e) => PopupMenuItem(
                      value: PageItem.indexOf(e),
                      child: Text('${e['titre']}',
                          style: GoogleFonts.roboto(fontSize: 16)),
                    )).toList());
      default:
        return TextButton(
          onPressed: () {
            Get.toNamed(widget.menu['route']);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(widget.menu['titre'],
                style: GoogleFonts.jost(
                    color: pColor.withOpacity(0.8), fontSize: 18)),
          ),
        );
    }
  }
}

class MenuPrincipalElementMobile extends StatefulWidget {
  final menu;
  const MenuPrincipalElementMobile({this.menu, Key? key}) : super(key: key);

  @override
  _MenuPrincipalElementMobileState createState() =>
      _MenuPrincipalElementMobileState();
}

class _MenuPrincipalElementMobileState
    extends State<MenuPrincipalElementMobile> {
  @override
  Widget build(BuildContext context) {
    switch (widget.menu['titre']) {
      case 'Catégorie':
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.menu['titre'],
                style: GoogleFonts.jost(color: Colors.white, fontSize: 22)),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: CategorieItem.map((e) => TextButton(
                      onPressed: () {
                        Get.toNamed('${e['route']}');
                      },
                      child: Text('${e['titre']}',
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: sColorLight.withOpacity(0.6))),
                    )).toList(),
              ),
            )
          ],
        );
//  case 'Pages':
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(widget.menu['titre'],
//                 style: GoogleFonts.jost(color: Colors.white, fontSize: 22)),
//             Container(
//               padding: EdgeInsets.only(left: 20),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: CategorieItem.map((e) => TextButton(
//                       onPressed: () {
//                         Get.toNamed('${e['route']}');
//                       },
//                       child: Text('${e['titre']}',
//                           style: GoogleFonts.roboto(
//                               fontSize: 16, color: sColorLight)),
//                     )).toList(),
//               ),
//             )
//           ],
//         );

//       case 'Pages':
//         return PopupMenuButton(
//             onSelected: (int e) {
//               Get.toNamed('${PageItem[e.toInt()]['route']}');
//             },
//             tooltip: 'Allez vers une page',
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8),
//               child: Text(widget.menu['titre'],
//                   style: GoogleFonts.jost(
//                       color: pColor.withOpacity(0.8), fontSize: 18)),
//             ),
//             itemBuilder: (BuildContext context) =>
//                 PageItem.map((e) => PopupMenuItem(
//                       value: PageItem.indexOf(e),
//                       child: Text('${e['titre']}',
//                           style: GoogleFonts.roboto(fontSize: 16)),
//                     )).toList());
      default:
        return TextButton(
          onPressed: () {
            Get.toNamed(widget.menu['route']);
          },
          child: Container(
            child: Text(widget.menu['titre'],
                style: GoogleFonts.jost(color: Colors.white, fontSize: 25)),
          ),
        );
    }
  }
}

class ChargementDefault extends StatelessWidget {
  const ChargementDefault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: sColorLight,
      child: Center(
        child: SpinKitFadingCircle(
          color: pColor,
          size: 40.0,
        ),
      ),
    );
  }
}

class Chargement extends StatelessWidget {
  const Chargement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sColorLight,
      body: Center(
        child: SpinKitFadingCircle(
          color: pColor,
          size: 40.0,
        ),
      ),
    );
  }
}
