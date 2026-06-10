// lib/widgets/badge_disponibilite.dart
// StatelessWidget : affiche seulement le statut du livre
// Ne modifie aucune donnée → Stateless justifié

import 'package:flutter/material.dart';

class BadgeDisponibilite extends StatelessWidget {
  final bool disponible;

  const BadgeDisponibilite({super.key, required this.disponible});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: disponible ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: disponible ? Colors.green.shade300 : Colors.red.shade300,
        ),
      ),
      child: Text(
        disponible ? 'Disponible' : 'Emprunté',
        style: TextStyle(
          color: disponible ? Colors.green[800] : Colors.red[700],
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}