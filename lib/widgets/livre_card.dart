import 'package:flutter/material.dart';
import '../models/livre.dart';
import 'badge_disponibilite.dart';

class LivreCard extends StatelessWidget {
  final Livre livre;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const LivreCard({
    super.key,
    required this.livre,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(livre.titre),
        subtitle: Text('${livre.auteur} · ${livre.categorie.label}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BadgeDisponibilite(disponible: livre.disponible),
            if (onDelete != null) ...[
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
