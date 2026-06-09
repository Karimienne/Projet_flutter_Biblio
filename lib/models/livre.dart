enum Categorie { roman, sciences, histoire, autre }

extension CategorieLabel on Categorie {
  String get label {
    switch (this) {
      case Categorie.roman:
        return 'Roman';
      case Categorie.sciences:
        return 'Sciences';
      case Categorie.histoire:
        return 'Histoire';
      case Categorie.autre:
        return 'Autre';
    }
  }
}

class Livre {
  final String id;
  final String titre;
  final String auteur;
  final Categorie categorie;
  bool disponible;
  String? emprunteur;

  Livre({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.categorie,
    required this.disponible,
    this.emprunteur,
  });

  String get statut => disponible ? 'Disponible' : 'Emprunté par $emprunteur';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'auteur': auteur,
      'categorie': categorie.name,
      'disponible': disponible,
      'emprunteur': emprunteur,
    };
  }
}
