import 'package:get/get.dart';

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
