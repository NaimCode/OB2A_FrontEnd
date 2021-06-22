import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:get/get.dart';
import 'package:ob2a/service/authentification.dart';
import 'package:ob2a/specialPages/inscription.dart';

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final _formKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey();
  var auth = Authentification(FirebaseAuth.instance);
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
                  'CONNEXION',
                  style: GoogleFonts.jost(
                      fontSize: 30, fontWeight: FontWeight.w200),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Saisir votre email';
                      } else {
                        if (value.isEmail)
                          return null;
                        else
                          return 'Saisir un email valide';
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
                      if (value == null || value.isEmpty)
                        return 'Saisir votre mot de passe';

                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open_outlined),
                        filled: true,
                        fillColor: sColor,
                        labelText: 'Mot de Passe'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Mot de passe oublié?',
                          textAlign: TextAlign.right,
                        )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 50)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var check =
                            await auth.connection(email.text, password.text);
                        switch (check) {
                          case 'Connexion réussi, ravis de vous revoir':
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(check)));
                            Get.toNamed('/');

                            break;

                          default:
                            error.value = check;
                            break;
                        }
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                      }
                    },
                    child: Text(
                      'Se connecter',
                      style: TextStyle(color: Colors.white),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),
                Row(
                  children: [
                    Text(
                      'Vous n\'avez pas encore un compte?',
                      style: GoogleFonts.poppins(
                          color: Colors.grey[500],
                          fontSize: isMobile ? 11 : null),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/inscription');
                      },
                      child: Text('S\'inscrire',
                          style: GoogleFonts.jost(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber)),
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
