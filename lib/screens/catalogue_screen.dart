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
  final List<Livre> _livres = List.from(livresInitiaux);
  List<Livre> _livresFiltres = List.from(livresInitiaux);
  final TextEditingController _searchController = TextEditingController();

  void _filtrer(String query) {
    setState(() {
      _livresFiltres = _livres
          .where((l) =>
              l.titre.toLowerCase().contains(query.toLowerCase()) ||
              l.auteur.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _supprimerLivre(String id) {
    setState(() {
      _livres.removeWhere((l) => l.id == id);
      _livresFiltres.removeWhere((l) => l.id == id);
    });
  }

  void _confirmerSuppression(Livre livre) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: Text('Supprimer "${livre.titre}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filtrer,
              decoration: const InputDecoration(
                hintText: 'Rechercher un livre...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _livresFiltres.isEmpty
                ? const Center(child: Text('Aucun livre trouvé.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _livresFiltres.length,
                    itemBuilder: (context, index) {
                      final livre = _livresFiltres[index];
                      return LivreCard(
                        livre: livre,
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: livre,
                        ).then((_) {
                          if (mounted) setState(() {});
                        }),
                        onDelete: () => _confirmerSuppression(livre),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/formulaire'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
