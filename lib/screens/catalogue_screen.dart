
import 'package:flutter/material.dart';

import '../models/livre.dart';
import '../data/livres_data.dart';

class CatalogueScreen extends StatelessWidget {
  final Widget Function(Livre livre) livreTile;

  const CatalogueScreen({
    super.key,
    required this.livreTile,
  });

  @override
  Widget build(BuildContext context) {
    final nouveautes = livres.where((livre) => livre.nouveaute).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
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

                return Container(
                  width: 110,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: livre.couleur,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    livre.titre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
            child: ListView.separated(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                return livreTile(livres[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  indent: 72,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
