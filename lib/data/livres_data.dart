// lib/data/livres_data.dart
// Les 6 ouvrages réels collectés
// Source : babelio.com / wikipedia.org — Juin 2026

import '../models/livre.dart';

final List<Livre> livresInitiaux = [
  Livre(
    id: '1',
    titre: 'Une si longue lettre',
    auteur: 'Mariama Bâ',
    categorie: Categorie.roman,
    imageAsset: 'assets/images/mariamaba.png',
    disponible: false,
    emprunteur: 'Fatou Diallo',
  ),
  Livre(
    id: '2',
    titre: 'Les Bouts de bois de Dieu',
    auteur: 'Ousmane Sembène',
    categorie: Categorie.roman,
    imageAsset: 'assets/images/boutdebois.png',
    disponible: true,
    emprunteur: null,
  ),
  Livre(
    id: '3',
    titre: 'Le Devoir de violence',
    auteur: 'Yambo Ouologuem',
    categorie: Categorie.roman,
    imageAsset: 'assets/images/devoirviolence.png',
    disponible: true,
    emprunteur: null,
  ),
  Livre(
    id: '4',
    titre: "L'Aventure ambiguë",
    auteur: 'Cheikh Hamidou Kane',
    categorie: Categorie.roman,
    imageAsset: 'assets/images/avambigue.png',
    disponible: false,
    emprunteur: 'Moussa Sow',
  ),
  Livre(
    id: '5',
    titre: 'Anthologie de la nouvelle poésie nègre et malgache',
    auteur: 'Léopold Sédar Senghor',
    categorie: Categorie.autre,
    imageAsset: 'assets/images/anthologie.png',
    disponible: true,
    emprunteur: null,
  ),
  Livre(
    id: '6',
    titre: "L'Afrique noire précoloniale",
    auteur: 'Cheikh Anta Diop',
    categorie: Categorie.histoire,
    imageAsset: 'assets/images/afprecoloniale.png',
    disponible: true,
    emprunteur: null,
  ),
];