import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../models/livre.dart';
import '../widgets/livre_card.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({super.key});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  List<Livre> _livres = List.from(livresInitiaux);
  List<Livre> _livresFiltres = List.from(livresInitiaux);
  bool _afficherDispo = false;

  void _filtrer(String recherche) {
    setState(() {
      _livresFiltres = _livres.where((livre) {
        final correspondRecherche =
            livre.titre.toLowerCase().contains(recherche.toLowerCase()) ||
            livre.auteur.toLowerCase().contains(recherche.toLowerCase());
        if (_afficherDispo) {
          return correspondRecherche && livre.disponible;
        }
        return correspondRecherche;
      }).toList();
    });
  }

  void _supprimerLivre(String id) {
    setState(() {
      _livres.removeWhere((livre) => livre.id == id);
      _livresFiltres.removeWhere((livre) => livre.id == id);
    });
  }

  void _confirmerSuppression(Livre livre) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: Text('Supprimer "${livre.titre}" ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Annuler'),
            ),

            // ======= LIVE 1 : SUPPRESSION AVEC CONFIRMATION =======
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                _supprimerLivre(livre.id);
              },
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
            // ======= FIN LIVE 1 =======
          ],
        );
      },
    );
  }

  void _mettreAJourLivre(Livre livre) {
    setState(() {
      final index = _livres.indexWhere((l) => l.id == livre.id);
      if (index >= 0) {
        _livres[index] = livre;
      } else {
        _livres.add(livre);
      }
      _filtrer('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, '/apropos'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: TextField(
              onChanged: _filtrer,
              decoration: InputDecoration(
                hintText: 'Rechercher un livre...',
                hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                prefixIcon:
                    const Icon(Icons.search, color: Color(0xFF9E9E9E)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
              ),
            ),
          ),

          // ======= LIVE 3 : FILTRE DISPONIBLES SEULEMENT =======
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Disponibles seulement',
                  style: TextStyle(fontSize: 13, color: Color(0xFF616161)),
                ),
                const Spacer(),
                Switch(
                  value: _afficherDispo,
                  onChanged: (valeur) {
                    setState(() {
                      _afficherDispo = valeur;
                      _filtrer('');
                    });
                  },
                ),
              ],
            ),
          ),
          // ======= FIN LIVE 3 =======

          Expanded(
            child: _livresFiltres.isEmpty
                ? const Center(
                    child: Text(
                      'Aucun livre trouvé.',
                      style: TextStyle(color: Color(0xFF9E9E9E)),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _livresFiltres.length,
                    itemBuilder: (context, index) {
                      final livre = _livresFiltres[index];
                      return LivreCard(
                        livre: livre,
                        onTap: () async {
                          final resultat = await Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: livre,
                          );
                          if (resultat != null && resultat is Livre) {
                            _mettreAJourLivre(resultat);
                          } else {
                            setState(() {});
                          }
                        },
                        onDelete: () => _confirmerSuppression(livre),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF424242),
        foregroundColor: Colors.white,
        onPressed: () async {
          final resultat =
              await Navigator.pushNamed(context, '/formulaire');
          if (resultat != null) {
            _mettreAJourLivre(resultat as Livre);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}