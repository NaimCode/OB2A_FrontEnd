import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:ob2a/data/class.dart';
import 'package:ob2a/responsive/desktop.dart';
import 'package:ob2a/responsive/mobile.dart';
import 'package:provider/provider.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  Utilisateur? user;
  @override
  Widget build(BuildContext context) {
    user = context.watch<Utilisateur?>();
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
            length: 4,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
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
                          Tab(
                              icon: Icon(Icons.settings_outlined),
                              text: "Paramètre"),
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
                    user: user!,
                  ),
                  Icon(Icons.directions_bike),
                  Icon(Icons.directions_bike),
                  Icon(Icons.directions_bike),
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