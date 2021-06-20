import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'data/class.dart';
import 'responsive/desktop.dart';
import 'responsive/mobile.dart';
import 'package:provider/provider.dart';

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
        endDrawer: isMobile ? Drawer() : null,
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
