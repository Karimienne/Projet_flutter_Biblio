import 'package:flutter/material.dart';

class AProposScreen extends StatelessWidget {
  const AProposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Développeuse', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Anta Cissé'),
            SizedBox(height: 16),
            Text('Source des données', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('babelio.com / wikipedia.org'),
            SizedBox(height: 16),
            Text('Date de collecte', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Juin 2026'),
            SizedBox(height: 16),
            Text('Sujet', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Bibliothèque scolaire numérique - ODD 4'),
          ],
        ),
      ), 
    );
  }
}
