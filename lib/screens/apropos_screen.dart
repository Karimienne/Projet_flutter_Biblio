// lib/screens/apropos_screen.dart
// StatelessWidget : affichage pur, aucune interaction → Stateless justifié

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AProposScreen extends StatelessWidget {
  const AProposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundColor: Color(0xFFEEEEEE),
              child: Icon(Icons.person_rounded, size: 40, color: Color(0xFF616161)),
            ),
            const SizedBox(height: 24),
            _InfoCard(
              icon: Icons.badge_outlined,
              label: 'Nom',
              value: 'Anta Cissé',
            ),
            const SizedBox(height: 12),
            _LinkInfoCard(
              icon: Icons.language_rounded,
              label: 'Source des données',
              links: const [
                _Lien(texte: 'babelio.com', url: 'https://www.babelio.com'),
                _Lien(texte: 'wikipedia.org', url: 'https://www.wikipedia.org'),
              ],
            ),
            const SizedBox(height: 12),
            _InfoCard(
              icon: Icons.calendar_today_outlined,
              label: 'Date de collecte',
              value: '09 Juin 2026',
            ),
            const SizedBox(height: 12),
            _InfoCard(
              icon: Icons.menu_book_outlined,
              label: 'Sujet',
              value: 'Bibliothèque scolaire numérique - ODD 4',
            ),
          ],
        ),
      ),
    );
  }
}

// Données d'un lien cliquable
class _Lien {
  final String texte;
  final String url;
  const _Lien({required this.texte, required this.url});
}

// Carte avec liens 
class _LinkInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<_Lien> links;

  const _LinkInfoCard({
    required this.icon,
    required this.label,
    required this.links,
  });

  Future<void> _ouvrir(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEEEEEE),
          child: Icon(icon, size: 20, color: const Color(0xFF616161)),
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9E9E9E),
            letterSpacing: 0.8,
          ),
        ),
        subtitle: Wrap(
          spacing: 12,
          children: links
              .map(
                (lien) => GestureDetector(
                  onTap: () => _ouvrir(lien.url),
                  child: Text(
                    lien.texte,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF1B5E20),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF1B5E20),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// Widget privé réutilisé dans cet écran uniquement
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEEEEEE),
          child: Icon(icon, size: 20, color: const Color(0xFF616161)),
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9E9E9E),
            letterSpacing: 0.8,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF212121),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
