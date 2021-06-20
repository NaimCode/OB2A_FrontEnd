class Utilisateur {
  String? uid;
  String? nom;
  String? email;
  String? password;
  String? image;
  List commande = [];
  List panier = [];
  bool? admin;
  String? boutique;

  Utilisateur.fromMap(Map<String, dynamic> data) {
    nom = data['nom'];
    uid = data['uid'];

    image = data['image'];
    email = data['email'];
    password = data['password'];
    boutique = data['boutique'];
    admin = data['admin'];
  }
  Utilisateur.fromDoc(var data) {
    nom = data['nom'];
    uid = data['uid'];

    image = data['image'];
    email = data['email'];
    password = data['password'];
    boutique = data['boutique'];
    admin = data['admin'];
  }
  Utilisateur(
      {this.uid,
      this.nom,
      this.boutique,
      this.password,
      this.email,
      this.image,
      this.admin});
}
