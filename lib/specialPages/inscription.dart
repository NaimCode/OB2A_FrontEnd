import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ob2a/constant/color.dart';
import 'package:ob2a/constant/miniWidget.dart';
import 'package:ob2a/service/authentification.dart';

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
  TextEditingController email = TextEditingController();
  TextEditingController nom = TextEditingController();
  var auth = Authentification(FirebaseAuth.instance);
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
                    controller: nom,
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
                    controller: email,
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
                        var check =
                            auth.enregistrementOnly(email.text, password.text);
                        switch (check) {
                          case 'Connexion réussie':
                            print('Connexion réussie');
                            Get.to(
                                VerifEmail(
                                    neew: true,
                                    mail: email.text,
                                    nom: nom.text,
                                    password: password.text),
                                fullscreenDialog: true);
                            break;
                          case 'Email existe déjà':
                            print('Email existe déjà');
                            error.value =
                                'Email existe déjà, veuillez-vous connecter';
                            break;
                          default:
                            print('Default');
                        }
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

class VerifEmail extends StatefulWidget {
  final String mail;
  final String password;
  final String nom;
  final bool neew;
  // final GoToAfterCheck goto;
  const VerifEmail({
    // this.goto,
    required this.neew,
    required this.mail,
    required this.nom,
    required this.password,
  });

  @override
  _VerifEmailState createState() => _VerifEmailState();
}

class _VerifEmailState extends State<VerifEmail> {
  final auth = FirebaseAuth.instance;
  late User userCreditial;
  late Timer timer;
  bool? newUser;
  @override
  void initState() {
    newUser = widget.neew;
    userCreditial = auth.currentUser!;
    userCreditial.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkEmail();
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> checkEmail() async {
    userCreditial = auth.currentUser!;
    await userCreditial.reload();
    if (userCreditial.emailVerified) {
      await userCreditial.reload();
      timer.cancel();

      var utilisateurs = {
        'nom': widget.nom,
        'email': userCreditial.email,
        'password': widget.password,
        'image': null,
        'boutique': null,
        'devise': 'Euro',
        'commande': [],
        'panier': [],
        'admin': false,
        'uid': userCreditial.uid,
      };
      await firestoreinstance
          .collection('Utilisateur')
          .doc(userCreditial.uid)
          .set(utilisateurs);
      await userCreditial.reload();
      // if (widget.goto.nom == 'Sign')
      newUser = false;
      Get.back();

      // ignore: unnecessary_statements

      // Get.rawSnackbar(
      //     title: "Inscription réussi",
      //     message: 'Bienvenue sur O\'B2A',
      //     icon: Icon(Icons.verified_user));
    }
  }

  delUSer() async {
    if (newUser!) {
      var f = Authentification(auth);
      f.deleteUser(widget.mail, widget.password);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    delUSer();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: 400,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Un Email vous a été envoyé',
                  style: GoogleFonts.jost(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Veuillez le vérifier afin de continuer',
                  style: GoogleFonts.jost(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                widget.mail,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              // Expanded(
              //   child: Chargement1(
              //       message: 'Veuillez vérifier votre Email',
              //       submessage: email.text),
              // ),
            ],
          )),
    );
  }
}

// class ConnexionField extends StatefulWidget {
//   const ConnexionField({
//     Key key,
//   }) : super(key: key);

//   @override
//   _ConnexionFieldState createState() => _ConnexionFieldState();
// }

// class _ConnexionFieldState extends State<ConnexionField> {
//   String erreurMail = '';
//   String erreurPass = '';
//   bool isChargingConnexion = false;
//   verif() {
//     email.text.isEmail ? erreurMail = '' : erreurMail = 'Email invalide';
//     pass.text.isEmpty ? erreurPass = 'Saisir un mot de passe' : erreurPass = '';
//     setState(() {});
//     if (erreurMail == '' && erreurPass == '') seConnecter();
//   }

//   seConnecter() async {
//     isChargingConnexion = true;
//     var check = await Authentification(FirebaseAuth.instance)
//         .connection(email.text, pass.text);
//     isChargingConnexion = false;
//     switch (check) {
//       case 'Le mot de passe est incorrect':
//         print('erreur password');
//         setState(() {
//           erreurPass = check;
//           erreurMail = '';
//         });
//         break;
//       case 'L\'Email est incorrect':
//         print('erreur email');
//         setState(() {
//           erreurPass = '';
//           erreurMail = check;
//         });
//         break;
//       case 'Connexion réussi, ravis de vous revoir':
//         Get.offNamed(_route);

//         break;
//       default:
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5),
//           child: TextFormField(
//             controller: email,
//             // initialValue: 'Input text',
//             decoration: InputDecoration(
//               prefixIcon: Icon(
//                 Icons.mail,
//                 color: Colors.grey[700],
//               ),
//               fillColor: backgroundColor1, filled: true,
//               errorText: erreurMail == '' ? null : erreurMail,
//               // labelText: 'Label text',
//               hintText: 'Email',
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5),
//           child: TextFormField(
//             obscureText: true,
//             controller: pass,
//             // initialValue: 'Input text',
//             decoration: InputDecoration(
//               prefixIcon: Icon(
//                 Icons.lock,
//                 color: Colors.grey[700],
//               ),
//               errorText: erreurPass == '' ? null : erreurPass,
//               fillColor: backgroundColor1, filled: true,
//               // labelText: 'Label text',
//               hintText: 'Mot de Passe',
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: InkWell(
//             onTap: verif,
//             child: Container(
//               width: double.infinity,
//               height: 50,
//               color: secondaryColor,
//               child: Center(
//                 child: isChargingConnexion
//                     ? ChargementMini(
//                         color: textColor,
//                       )
//                     : Text('Se connecter',
//                         style: TextStyle(color: textColor, fontSize: 20)),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }