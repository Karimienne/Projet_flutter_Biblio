import '../models/livre.dart';

final List<Livre> livresInitiaux = [
  Livre(
    id: '1',
    titre: 'Une si longue lettre',
    auteur: 'Mariama Bâ',
    categorie: Categorie.roman,
    disponible: true,
    emprunteur: null,
  ),
  Livre(
    id: '2',
    titre: 'Les Bouts de bois de Dieu',
    auteur: 'Ousmane Sembène',
    categorie: Categorie.roman,
    disponible: false,
    emprunteur: 'Fatou Diallo',
  ),
  Livre(
    id: '3',
    titre: 'Le Devoir de violence',
    auteur: 'Yambo Ouologuem',
    categorie: Categorie.roman,
    disponible: true,
    emprunteur: null,
  ),
  Livre(
    id: '4',
    titre: "L'Aventure ambiguë",
    auteur: 'Cheikh Hamidou Kane',
    categorie: Categorie.roman,
    disponible: false,
    emprunteur: 'Moussa Sow',
  ),
  Livre(
    id: '5',
    titre: 'Anthologie de la nouvelle poésie nègre et malgache',
    auteur: 'Léopold Sédar Senghor',
    categorie: Categorie.autre,
    disponible: true,
    emprunteur: null,
  ),
  Livre(
    id: '6',
    titre: "L'Afrique noire précoloniale",
    auteur: 'Cheikh Anta Diop',
    categorie: Categorie.histoire,
    disponible: true,
    emprunteur: null,
  ),
];