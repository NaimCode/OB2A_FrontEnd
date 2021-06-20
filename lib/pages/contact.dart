import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      color: sColorLight,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(color: sColor.withOpacity(0.4), height: 2)),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: SelectableText(
                  'CONTACT',
                  style: GoogleFonts.jost(
                      fontWeight: FontWeight.w300,
                      fontSize: isMobile ? 25 : 40,
                      wordSpacing: 2),
                ),
              ),
              Expanded(
                  child: Container(color: sColor.withOpacity(0.4), height: 2)),
            ],
          ),
          Container(
            width: 700,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Text(
                'Bien d\'un partenariat? Ou besoin d\'une chose spécifique? Veuillez juste nous contacter',
                textAlign: TextAlign.center,
                style: GoogleFonts.jost(
                    fontSize: 18, fontWeight: FontWeight.w200)),
          ),
          Container(
            width: 400,
            padding: EdgeInsets.only(bottom: isMobile ? 40 : 60),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  cursorColor: sColorStrong,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    icon: Icon(Icons.person_outline_outlined),
                    labelText: 'Nom',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: sColor,
                    ),
                    border: OutlineInputBorder(
                        // borderSide: BorderSide(color: pColor),
                        ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: sColorStrong,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    icon: Icon(Icons.mail_outline_outlined),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: sColor,
                    ),
                    border: OutlineInputBorder(
                        // borderSide: BorderSide(color: pColor),
                        ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: sColorStrong,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    icon: Icon(Icons.text_fields_outlined),
                    labelText: 'Objet',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: sColor,
                    ),
                    border: OutlineInputBorder(
                        // borderSide: BorderSide(color: pColor),
                        ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  minLines: 4,
                  maxLines: 6,
                  cursorColor: sColorStrong,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    icon: Icon(Icons.message_outlined),
                    labelText: 'Message',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: sColor,
                    ),
                    border: OutlineInputBorder(
                        // borderSide: BorderSide(color: pColor),
                        ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: pColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Envoyer',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
