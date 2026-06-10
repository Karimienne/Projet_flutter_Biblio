// lib/models/livre.dart

import 'package:flutter/material.dart';

enum Categorie { roman, sciences, histoire, autre }

extension CategorieColor on Categorie {
  Color get couleur {
    switch (this) {
      case Categorie.roman:
        return const Color(0xFFBBDEFB);
      case Categorie.sciences:
        return const Color(0xFFC8E6C9);
      case Categorie.histoire:
        return const Color(0xFFFFE0B2);
      case Categorie.autre:
        return const Color(0xFFE1BEE7);
    }
  }
}

class Livre {
  final String id;
  final String titre;
  final String auteur;
  final Categorie categorie;
  final String imageAsset; // chemin vers l'image dans assets/
  bool disponible;
  String? emprunteur; // null safety : peut être absent

  // Constructeur avec paramètres nommés (exigé)
  Livre({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.categorie,
    required this.imageAsset,
    required this.disponible,
    this.emprunteur,
  });

  // Méthode calculée (exigée par le prof)
  String get statut {
    if (disponible) {
      return 'Disponible';
    } else {
      return 'Emprunté par $emprunteur';
    }
  }

  // Usage de Map (exigé par le prof)
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