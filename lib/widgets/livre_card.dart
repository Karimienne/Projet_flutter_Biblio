import 'package:flutter/material.dart';
import '../models/livre.dart';
import 'badge_disponibilite.dart';

class LivreCard extends StatelessWidget {
  final Livre livre;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const LivreCard({
    super.key,
    required this.livre,
    required this.onTap,
    required this.onDelete,
  });

  Widget _imageOuCouleur() {
    if (livre.imageAsset.isEmpty) {
      return Container(
        width: 50,
        height: 68,
        decoration: BoxDecoration(
          color: livre.categorie.couleur,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            livre.categorie.name[0].toUpperCase(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.asset(
        livre.imageAsset,
        width: 50,
        height: 68,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 50,
            height: 68,
            decoration: BoxDecoration(
              color: livre.categorie.couleur,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                livre.categorie.name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 22,
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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Image ou couleur selon catégorie
              _imageOuCouleur(),
              const SizedBox(width: 14),

              // Infos du livre
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      livre.titre,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF212121),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      livre.auteur,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF757575),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            livre.categorie.name,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF616161),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        BadgeDisponibilite(disponible: livre.disponible),
                      ],
                    ),
                  ],
                ),
              ),

              // Bouton supprimer
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFBDBDBD),
                  size: 20,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}