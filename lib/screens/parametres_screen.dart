
import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Mon profil'),
          subtitle: const Text('Nom, e-mail, mot de passe'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profil sélectionné'),
              ),
            );
          },
        ),

        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          trailing: const Icon(Icons.chevron_right),
          tileColor: Colors.blue.shade50,
          iconColor: Colors.blue,
          textColor: Colors.blue.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Langue'),
          subtitle: const Text('Français'),
          trailing: const Icon(Icons.chevron_right),
        ),

        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('À propos'),
          subtitle: const Text('MaBiblio\nVersion 1.0'),
          trailing: const Icon(Icons.chevron_right),

          // Q1.4 :
          // dense: true réduit la hauteur du ListTile.
          // isThreeLine: true adapte sa hauteur à trois lignes.
          // enabled: false désactive les interactions.
          isThreeLine: true,
        ),

        // Q2.1 : éléments supplémentaires pour tester le défilement.
        for (int i = 1; i <= 10; i++)
          ListTile(
            leading: const Icon(Icons.book),
            title: Text('Livre supplémentaire $i'),
            subtitle: const Text('Élément de test'),
          ),
      ],
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: tiles,
      ),
    );
  }
}
