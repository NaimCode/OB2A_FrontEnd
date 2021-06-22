import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'constant/miniWidget.dart';
import 'data/class.dart';
import 'data/internal.dart';
import 'responsive/desktop.dart';
import 'responsive/mobile.dart';
import 'package:provider/provider.dart';

import 'state/globalVariable.dart';
import 'utils/function.dart';

class Body extends StatefulWidget {
  final content;
  Body({Key? key, this.content}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
        endDrawer: isMobile
            ? Drawer(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: double.infinity,
                  width: double.infinity,
                  color: pColor,
                  child: ListView(
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: sColorLight.withOpacity(0.7),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
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
                                icon: Icon(Icons.search_outlined,
                                    color: sColorLight)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children:
                            MenuPrincipal.map((e) => MenuPrincipalElementMobile(
                                  menu: e,
                                )).toList(),
                      ),
                    ],
                  ),
                ),
              )
            : null,
        body: CustomScrollView(
          slivers: [
            isMobile ? MobileAppBar() : WebAppBar(),
            SliverList(
                delegate: SliverChildListDelegate([
              widget.content,
              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                color: sColor,
                child: Center(
                  child: Text('© 2021 O\'B2A',
                      style: GoogleFonts.jost(
                          fontSize: 18, fontWeight: FontWeight.w200)),
                ),
              )
            ]))
          ],
        ));
  }
}
