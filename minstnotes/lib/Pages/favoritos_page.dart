import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minstnotes/Widgets/scaffold.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  FavoritosPageState createState() => FavoritosPageState();
}

class FavoritosPageState extends State<FavoritosPage> {
  final _notesBox = Hive.box('notes');

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: 'Favoritos',
      body: ValueListenableBuilder(
        valueListenable: _notesBox.listenable(),
        builder: (context, Box box, _) {
          List<Map> favoriteNotes = [];

          // Filtrar solo los favoritos y asegurar estructura
          for (int i = 0; i < box.length; i++) {
            var noteData = box.getAt(i);
            if (noteData is Map && noteData['favorite'] == true) {
              favoriteNotes.add({'index': i, ...noteData});
            }
          }

          if (favoriteNotes.isEmpty) {
            return const Center(child: Text('No hay notas favoritas.'));
          }

          return ListView.builder(
            itemCount: favoriteNotes.length,
            itemBuilder: (context, index) {
              var note = favoriteNotes[index];

              return Card(
                color: Color(note['color']),
                child: ListTile(
                  title: Text(note['text']),
                  trailing: IconButton(
                    icon: const Icon(Icons.star, color: Colors.amber),
                    onPressed: () => _toggleFavorite(note['index']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _toggleFavorite(int index) {
    var note = _notesBox.getAt(index);
    if (note is Map) {
      note['favorite'] = false; // Quitar de favoritos
      _notesBox.putAt(index, note);
      setState(() {}); // Refrescar UI
    }
  }
}
