import 'package:flutter/material.dart';

class BadgeDisponibilite extends StatelessWidget {
  final bool disponible;

  const BadgeDisponibilite({super.key, required this.disponible});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: disponible ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        disponible ? 'Disponible' : 'Emprunté',
        style: TextStyle(
          color: disponible ? Colors.green[800] : Colors.red[800],
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
