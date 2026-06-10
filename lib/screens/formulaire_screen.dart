import 'package:flutter/material.dart';
import '../models/livre.dart';

class FormulaireScreen extends StatefulWidget {
  const FormulaireScreen({super.key});

  @override
  State<FormulaireScreen> createState() => _FormulaireScreenState();
}

class _FormulaireScreenState extends State<FormulaireScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _auteurController = TextEditingController();
  Categorie _categorie = Categorie.roman;
  bool _estModification = false;
  Livre? _livreOriginal;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg is Livre) {
        setState(() {
          _estModification = true;
          _livreOriginal = arg;
          _titreController.text = arg.titre;
          _auteurController.text = arg.auteur;
          _categorie = arg.categorie;
        });
      }
    });
  }

  @override
  void dispose() {
    _titreController.dispose();
    _auteurController.dispose();
    super.dispose();
  }

  // ======= LIVE 1 : CRÉATION AVEC VALIDATION =======
  void _sauvegarder() {
    if (_formKey.currentState!.validate()) {
      final livre = Livre(
        id: _estModification
            ? _livreOriginal!.id
            : DateTime.now().millisecondsSinceEpoch.toString(),
        titre: _titreController.text.trim(),
        auteur: _auteurController.text.trim(),
        categorie: _categorie,
        imageAsset: _estModification ? _livreOriginal!.imageAsset : '',
        disponible: _estModification ? _livreOriginal!.disponible : true,
        emprunteur: _estModification ? _livreOriginal!.emprunteur : null,
      );
      Navigator.pop(context, livre);
    }
  }
  // ======= FIN LIVE 1 =======

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _estModification ? 'Modifier le livre' : 'Ajouter un livre',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Titre',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xFF424242))),
              const SizedBox(height: 6),
              TextFormField(
                controller: _titreController,
                decoration: InputDecoration(
                  hintText: 'Titre du livre',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0xFFE0E0E0))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0xFFE0E0E0))),
                ),
                // ======= LIVE 1 : VALIDATOR TITRE =======
                validator: (valeur) {
                  if (valeur == null || valeur.trim().isEmpty) {
                    return 'Le titre est obligatoire';
                  }
                  return null;
                },
                // ======= FIN LIVE 1 =======
              ),
              const SizedBox(height: 16),

              const Text('Auteur',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xFF424242))),
              const SizedBox(height: 6),
              TextFormField(
                controller: _auteurController,
                decoration: InputDecoration(
                  hintText: "Nom de l'auteur",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0xFFE0E0E0))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color(0xFFE0E0E0))),
                ),
                // ======= LIVE 1 : VALIDATOR AUTEUR =======
                validator: (valeur) {
                  if (valeur == null || valeur.trim().isEmpty) {
                    return "L'auteur est obligatoire";
                  }
                  return null;
                },
                // ======= FIN LIVE 1 =======
              ),
              const SizedBox(height: 16),

              const Text('Catégorie',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xFF424242))),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Categorie>(
                    isExpanded: true,
                    value: _categorie,
                    items: const [
                      DropdownMenuItem(
                          value: Categorie.roman, child: Text('Roman')),
                      DropdownMenuItem(
                          value: Categorie.sciences,
                          child: Text('Sciences')),
                      DropdownMenuItem(
                          value: Categorie.histoire,
                          child: Text('Histoire')),
                      DropdownMenuItem(
                          value: Categorie.autre, child: Text('Autre')),
                    ],
                    onChanged: (valeur) {
                      if (valeur != null) {
                        setState(() => _categorie = valeur);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _sauvegarder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF424242),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    _estModification
                        ? 'Enregistrer'
                        : 'Ajouter le livre',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}