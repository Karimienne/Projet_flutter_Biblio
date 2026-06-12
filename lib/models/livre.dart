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

  // Sérialisation vers Map (pour SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'auteur': auteur,
      'categorie': categorie.name,
      'imageAsset': imageAsset,
      'disponible': disponible,
      'emprunteur': emprunteur,
    };
  }

  // Désérialisation depuis Map (pour SharedPreferences)
  factory Livre.fromMap(Map<String, dynamic> map) {
    return Livre(
      id: map['id'] as String,
      titre: map['titre'] as String,
      auteur: map['auteur'] as String,
      categorie: Categorie.values.firstWhere((c) => c.name == map['categorie']),
      imageAsset: map['imageAsset'] as String,
      disponible: map['disponible'] as bool,
      emprunteur: map['emprunteur'] as String?,
    );
  }
}