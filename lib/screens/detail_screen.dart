import 'package:flutter/material.dart';
import '../models/livre.dart';
import '../widgets/badge_disponibilite.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _emprunteurController =
      TextEditingController();

  @override
  void dispose() {
    _emprunteurController.dispose();
    super.dispose();
  }

  Widget _imageOuCouleur(Livre livre) {
    if (livre.imageAsset.isEmpty) {
      return Container(
        width: 140,
        height: 200,
        decoration: BoxDecoration(
          color: livre.categorie.couleur,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            livre.categorie.name[0].toUpperCase(),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        livre.imageAsset,
        height: 200,
        width: 140,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 140,
            height: 200,
            decoration: BoxDecoration(
              color: livre.categorie.couleur,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                livre.categorie.name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ======= LIVE 2 : BASCULE EMPRUNTER / RENDRE =======
  void _basculerEmprunt(Livre livre) {
    if (livre.disponible) {
      if (_emprunteurController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Entrez le nom de l'emprunteur")),
        );
        return;
      }
      setState(() {
        livre.disponible = false;
        livre.emprunteur = _emprunteurController.text.trim();
      });
    } else {
      setState(() {
        livre.disponible = true;
        livre.emprunteur = null;
        _emprunteurController.clear();
      });
    }
  }
  // ======= FIN LIVE 2 =======

  @override
  Widget build(BuildContext context) {
    // Réception de l'argument depuis CatalogueScreen (exigé)
    final Livre livre =
        ModalRoute.of(context)!.settings.arguments as Livre;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du livre'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () async {
              final resultat = await Navigator.pushNamed(
                context,
                '/formulaire',
                arguments: livre,
              );
              if (resultat != null && resultat is Livre) {
                // Retourne le livre modifié au catalogue
                Navigator.pop(context, resultat);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image ou couleur selon catégorie
            Center(child: _imageOuCouleur(livre)),
            const SizedBox(height: 24),

            // Titre
            Text(
              livre.titre,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 6),

            // Auteur
            Text(
              livre.auteur,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF757575),
              ),
            ),
            const SizedBox(height: 14),

            // Catégorie + badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    livre.categorie.name,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF616161)),
                  ),
                ),
                const SizedBox(width: 10),
                BadgeDisponibilite(disponible: livre.disponible),
              ],
            ),
            const SizedBox(height: 10),

            // Statut — méthode calculée du modèle
            Text(
              livre.statut,
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: livre.disponible
                    ? Colors.green[700]
                    : Colors.red[700],
              ),
            ),

            const Divider(height: 36),

            // Champ emprunteur — visible si disponible
            if (livre.disponible) ...[
              const Text(
                "Nom de l'emprunteur",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emprunteurController,
                decoration: InputDecoration(
                  hintText: 'Entrez le nom...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Bouton Emprunter ou Rendre
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _basculerEmprunt(livre),
                style: ElevatedButton.styleFrom(
                  backgroundColor: livre.disponible
                      ? const Color(0xFF424242)
                      : Colors.orange[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  livre.disponible ? 'Emprunter' : 'Rendre',
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}