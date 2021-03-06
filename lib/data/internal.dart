const MenuPrincipal = [
  {
    'titre': 'Accueil',
    'route': '/',
  },
  {
    'titre': 'Promotion',
    'route': '/produit?query=enPromotion&value=true',
  },
  {
    'titre': 'Contact',
    'route': '/pages/contact',
  },
  {
    'titre': 'Catégorie',
    'route': '/categorie',
  },

  // {
  //   'titre': 'Pages',
  //   'route': '/pages',
  // }
];
const CategorieItem = [
  {
    'titre': 'Accessoires',
    'route': '/produits/accessoires?type=categorie',
  },
  {
    'titre': 'Beauté et Cosmétique',
    'route': '/produits/beaute-et-cosmetique?type=categorie',
  },
  {
    'titre': 'Enfant',
    'route': '/produits/enfant?type=categorie',
  },
  {
    'titre': 'Homme',
    'route': '/produits/homme?type=categorie',
  },
  {
    'titre': 'Femme',
    'route': '/produits/femme?type=categorie',
  },
  {
    'titre': 'Santé',
    'route': '/produits/sante?type=categorie',
  },
  {
    'titre': 'Numérique',
    'route': '/produits/numerique?type=categorie',
  },
  {
    'titre': 'Électroménagers',
    'route': '/produits/electromenagers?type=categorie',
  },
  {
    'titre': 'Épicerie',
    'route': '/produits/epicerie?type=categorie',
  },
  {
    'titre': 'Maison',
    'route': '/produits/maison?type=categorie',
  },
  {
    'titre': 'Autre',
    'route': '/produits/autre?type=categorie',
  },
];
const PageItem = [
  {
    'titre': 'Contact',
    'route': '/pages/contact',
  },
  // {
  //   'titre': 'Apropos De Nous',
  //   'route': '/pages/apropos-de-nous',
  // },
  // {
  //   'titre': 'FAQ',
  //   'route': '/pages/faq',
  // },
  // {
  //   'titre': 'O\'B2A pro',
  //   'route': '/pages/pro',
  // },
];
const CategorieHome = [
  {
    'image': 'images/womenFashion.png',
    'route': '/produits/femme?type=categorie',
    'titre': 'Femme'
  },
  {
    'image': 'images/menfashion.png',
    'route': '/produits/homme?type=categorie',
    'titre': 'Homme'
  },
  {
    'image': 'images/kidFashion.png',
    'route': '/produits/enfant?type=categorie',
    'titre': 'Enfant'
  }
];

List<String> allDevise = <String>[
  'Euro',
  'Dollar',
  'FCFA',
];
