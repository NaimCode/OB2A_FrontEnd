import 'package:get/get.dart';
import 'package:ob2a/data/class.dart';

import '../env.dart';

String getTypeRoute(var get) {
  switch (get['type']) {
    case 'categorie':
      return '/categories?slug=${get['slug']}';
    case 'collection':
      return '/collections?slug=${get['slug']}';
    default:
      return '/categories?slug=femme';
  }
}

String getImageUrl(var e, var size) {
  if (size == 'large')
    return e['image'][0] == null
        ? e['image']['url']
        : e['image'][0]['url'] ?? ERROR_NETWORK_IMAGE;
  else
    return e['image'][0] == null
        ? e['image']['formats'][size]['url']
        : e['image'][0]['formats'][size]['url'] ?? ERROR_NETWORK_IMAGE;
}

getPrice(var produits) {
  if (produits['enPromotion'] == true && produits['prixPromotion'] != null)
    return produits['prixPromotion'];
  else
    return produits['prix'];
}

String getImageUrlMini(var e, var size) {
  if (size == 'large')
    return e == null
        ? e['image']['url']
        : e['image'][0]['url'] ?? ERROR_NETWORK_IMAGE;
  else
    return e['image'][0] == null
        ? e['image']['formats'][size]['url']
        : e['image'][0]['formats'][size]['url'] ?? ERROR_NETWORK_IMAGE;
}

onSearched(String s) {
  List listQuery = s.split(' ');
  var value;
  for (var i = 0; i < listQuery.length; i++) {
    i == 0 ? value = listQuery[i] : value += '_${listQuery[i]}';
  }
  var query = 'titre_contains';

  Get.toNamed('/produit?query=$query&value=$value');
  // Get.toNamed('/produit?recherche=$s');
}

getStringFromUrl(var l) {
  var s;
  l = l.split('_');
  for (var i = 0; i < l.length; i++) {
    i == 0 ? s = l[i] : s += ' ${l[i]}';
  }
  return s;
}

getQueryUrl(var s) {
  return '?${s['query']}=${s['value']}';
  // Get.toNamed('/produit?recherche=$s');
}

getTitle(String s, int i, var l) {
  switch (s) {
    case 'enPromotion':
      return 'PROMOTION';
    case 'titre_contains':
      return '$i produit(s) trouvés pour: ${getStringFromUrl(l)}';
    default:
  }
}

bool isUser(Utilisateur? user) {
  if (user!.uid == 'Anonyme')
    return false;
  else
    return true;
}

bool isExist(List l, var e) {
  for (var i in l) {
    if (i == e) {
      return true;
    }
  }
  return false;
}

getTabCompte(String s) {
  switch (s) {
    case 'panier':
      return 1;
    case 'commande':
      return 2;
    case 'parametre':
      return 3;
    default:
      return 0;
  }
}
