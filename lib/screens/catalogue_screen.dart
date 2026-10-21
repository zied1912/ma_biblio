
import 'package:flutter/material.dart';

import '../data/livres_data.dart';
import '../models/livre.dart';
import '../widgets/livre_card.dart';
import 'detail_screen.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  
  void _ouvrirDetail(BuildContext context, Livre livre) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(livre: livre),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final nouveautes =
        livres.where((livre) => livre.nouveaute).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Nouveautés
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Nouveautés',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nouveautes.length,
              itemBuilder: (context, index) {
                final livre = nouveautes[index];

                return SizedBox(
                  width: 300,
                  child: LivreCard(
                    livre: livre,
                    onTap: () {
                      _ouvrirDetail(context, livre);
                    },
                  ),
                );
              },
            ),
          ),

          
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Tout le catalogue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          
          Expanded(
            child: ListView.builder(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                final livre = livres[index];

                return LivreCard(
                  livre: livre,
                  onTap: () {
                    _ouvrirDetail(context, livre);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
