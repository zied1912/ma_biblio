
import 'package:flutter/material.dart';

import 'models/livre.dart';
import 'data/livres_data.dart';
import 'screens/parametres_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      debugShowCheckedModeBanner: false,
      
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Q1.7 : fonction qui représente un livre avec un ListTile
  Widget livreTile(Livre livre) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: livre.couleur,
        child: Text(
          livre.titre[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      title: Text(livre.titre),

      subtitle: Text('${livre.auteur} – ${livre.annee}'),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(livre.note.toString()),
          const SizedBox(width: 4),
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ],
      ),

      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(livre.titre),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaBiblio'),

        
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Paramètres',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParametresScreen(),
                ),
              );
            },
          ),
        ],
      ),

     
      body: ListView(
        children: livres.take(3).map(livreTile).toList(),
      ),
    );
  }
}