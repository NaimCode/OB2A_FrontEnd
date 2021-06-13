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
