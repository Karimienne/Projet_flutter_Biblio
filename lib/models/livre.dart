// lib/models/livre.dart

// Enum des 4 catégories possibles
enum Categorie { roman, sciences, histoire, autre }

class Livre {
  final String id;
  final String titre;
  final String auteur;
  final Categorie categorie;
  final String imageAsset; 
  bool disponible;
  String? emprunteur; 

  // Constructeur avec paramètres nommés 
  Livre({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.categorie,
    required this.imageAsset,
    required this.disponible,
    this.emprunteur,
  });

  // Méthode calculée 
  String get statut {
    if (disponible) {
      return 'Disponible';
    } else {
      return 'Emprunté par $emprunteur';
    }
  }

  // Usage de Map 
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
