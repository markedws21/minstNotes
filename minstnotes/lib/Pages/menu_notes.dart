import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minstnotes/Widgets/scaffold.dart';

class MenuNotesPage extends StatefulWidget {
  const MenuNotesPage({super.key});

  @override
  MenuNotesPageState createState() => MenuNotesPageState();
}

class MenuNotesPageState extends State<MenuNotesPage> {
  final _notesBox = Hive.box('notes');
  final List<Color> _colorOptions = [
    Colors.white,
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
    Colors.purple.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: 'Mis Notas',
      body: ValueListenableBuilder(
        valueListenable: _notesBox.listenable(),
        builder: (context, Box box, _) {
          List<Map> notes = [];

          for (int i = 0; i < box.length; i++) {
            var noteData = box.getAt(i);
            if (noteData is! Map) {
              noteData = {'text': noteData.toString(), 'color': Colors.white.value, 'favorite': false, 'image': null};
              _notesBox.putAt(i, noteData);
            } else {
              noteData['color'] ??= Colors.white.value;
              noteData['favorite'] ??= false;
              noteData['image'] ??= null;
              _notesBox.putAt(i, noteData);
            }
            notes.add({'index': i, ...noteData});
          }

          if (notes.isEmpty) {
            return const Center(child: Text('No hay notas aún.'));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              var note = notes[index];

              return Card(
                color: Color(note['color']),
                child: ListTile(
                  title: Text(note['text']),
                  subtitle: note['image'] != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.file(File(note['image']), height: 100, fit: BoxFit.cover),
                        )
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          note['favorite'] ? Icons.star : Icons.star_border,
                          color: note['favorite'] ? Colors.amber : null,
                        ),
                        onPressed: () => _toggleFavorite(note['index']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteNote(note['index']),
                      ),
                    ],
                  ),
                  onTap: () => _editNote(context, note['index'], note),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNote(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNote() {
    _notesBox.add({'text': 'Nueva Nota', 'color': Colors.white.value, 'favorite': false, 'image': null});
  }

  void _editNote(BuildContext context, int index, Map noteData) {
    TextEditingController controller = TextEditingController(text: noteData['text']);
    String? imagePath = noteData['image'];
    Color selectedColor = Color(noteData['color']);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Editar Nota'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: controller),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _colorOptions.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setDialogState(() {
                            selectedColor = color;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: selectedColor == color ? Border.all(width: 2, color: Colors.black) : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  imagePath != null
                      ? Image.file(File(imagePath!), height: 100, fit: BoxFit.cover)
                      : const SizedBox.shrink(),
                  TextButton(
                    onPressed: () async {
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setDialogState(() {
                          imagePath = pickedFile.path;
                        });
                      }
                    },
                    child: const Text('Seleccionar Imagen'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    noteData['text'] = controller.text;
                    noteData['image'] = imagePath;
                    noteData['color'] = selectedColor.value;
                    _notesBox.putAt(index, noteData);
                    Navigator.pop(context);
                    setState(() {}); // Refrescar la pantalla principal
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteNote(int index) {
    _notesBox.deleteAt(index);
  }

  void _toggleFavorite(int index) {
    var note = _notesBox.getAt(index);
    if (note is Map) {
      note['favorite'] = !(note['favorite'] ?? false);
      _notesBox.putAt(index, note);
      setState(() {});
    }
  }
}
