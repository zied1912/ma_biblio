
import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../models/livre.dart';

class MaListeScreen extends StatefulWidget {
  const MaListeScreen({super.key});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  bool _nouveautesSeulement = false;

  final Map<String, bool> _genres = {
    'Roman': true,
    'Science': true,
    'Histoire': true,
    'Jeunesse': true,
    'Informatique': true,
  };

  IconData _iconeGenre(String genre) {
    switch (genre) {
      case 'Roman':
        return Icons.menu_book;
      case 'Science':
        return Icons.science;
      case 'Histoire':
        return Icons.history_edu;
      case 'Jeunesse':
        return Icons.child_care;
      case 'Informatique':
        return Icons.computer;
      default:
        return Icons.book;
    }
  }

  List<Livre> get _livresFiltres {
    return livres.where((livre) {
      final genreSelectionne = _genres[livre.genre] ?? false;
      final nouveauteAcceptee =
          !_nouveautesSeulement || livre.nouveaute;

      return genreSelectionne && nouveauteAcceptee;
    }).toList();
  }

  bool? get _tousLesGenres {
    if (_genres.values.every((selectionne) => selectionne)) {
      return true;
    }

    if (_genres.values.every((selectionne) => !selectionne)) {
      return false;
    }

    return null;
  }

  int get _nombreLivresLus {
    return _livresFiltres.where((livre) => livre.lu).length;
  }

  @override
  Widget build(BuildContext context) {
    final livresAffiches = _livresFiltres;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ma liste — Lus : $_nombreLivresLus / ${livresAffiches.length}',
        ),
      ),
      body: Column(
        children: [
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            activeColor: Colors.blue,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                _nouveautesSeulement = value ?? false;
              });
            },
          ),

          CheckboxListTile(
            title: const Text(
              'Tous les genres',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            value: _tousLesGenres,
            tristate: true,
            activeColor: Colors.blue,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                final selectionnerTous = _tousLesGenres != true;

                for (final genre in _genres.keys) {
                  _genres[genre] = selectionnerTous;
                }
              });
            },
          ),

          ..._genres.keys.map((genre) {
            final nombreLivres =
                livres.where((livre) => livre.genre == genre).length;

            return CheckboxListTile(
              title: Text(genre),
              subtitle: Text('$nombreLivres livre(s)'),
              secondary: Icon(_iconeGenre(genre)),
              value: _genres[genre],
              activeColor: Colors.teal,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  _genres[genre] = value ?? false;
                });
              },
            );
          }),

          Expanded(
            child: ListView.builder(
              itemCount: livresAffiches.length,
              itemBuilder: (context, index) {
                final livre = livresAffiches[index];

                return CheckboxListTile(
                  value: livre.lu,
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                  secondary: CircleAvatar(
                    backgroundColor: livre.couleur,
                    child: Text(
                      livre.titre[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    livre.titre,
                    style: TextStyle(
                      decoration: livre.lu
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text('${livre.auteur} — ${livre.annee}'),
                  onChanged: (value) {
                    setState(() {
                      livre.lu = value ?? false;
                    });
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
