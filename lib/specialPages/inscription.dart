import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey();
  var error = ''.obs;
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
        body: Row(
      children: [
        isMobile
            ? Container()
            : Expanded(
                child: Container(
                height: double.infinity,
                child: Image.asset(
                  'images/imageLog.jpg',
                  fit: BoxFit.cover,
                ),
              )),
        Container(
          width: isMobile ? MediaQuery.of(context).size.width : 400,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Logo(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),
                Text(
                  'INSCRIPTION',
                  style: GoogleFonts.jost(
                      fontSize: 30, fontWeight: FontWeight.w200),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Obx(() => Text(
                        error.value,
                        style: GoogleFonts.roboto(color: Colors.red),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ajoutez un nom';
                      } else {
                        if (value.length <= 3)
                          return 'Ajouter un nom avec au moins trois(3) caractères';
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        filled: true,
                        fillColor: sColor,
                        labelText: 'Nom'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ajoutez un email';
                      } else {
                        if (value.isEmail)
                          return null;
                        else
                          return 'Ajouter un email valide';
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline_outlined),
                        filled: true,
                        fillColor: sColor,
                        labelText: 'Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    obscureText: true,
                    key: _passwordKey,
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ajoutez un mot de passe';
                      } else {
                        if (value.length >= 6)
                          return null;
                        else
                          return 'Ajouter un mot de passe avec au moins six(6) caratères';
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open_outlined),
                        filled: true,
                        fillColor: sColor,
                        labelText: 'Mot de Passe'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value != password.text)
                        return 'Mot de passe différent';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open_outlined),
                        filled: true,
                        fillColor: sColor,
                        labelText: 'Confirmation du Mot de Passe'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 50)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('S\'inscrire')),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),
                Row(
                  children: [
                    Text(
                      'Vous avez déjà un compte?',
                      style: GoogleFonts.poppins(color: Colors.grey[500]),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/connexion');
                      },
                      child: Text('Se connecter',
                          style: GoogleFonts.jost(
                              fontWeight: FontWeight.bold, color: Colors.blue)),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
