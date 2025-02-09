import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:minstnotes/Widgets/scaffold.dart';

class MenuNotesPage extends StatefulWidget {
  final NotchBottomBarController? controller;
  const MenuNotesPage({super.key, this.controller});

  @override
  MenuNotesPageState createState() => MenuNotesPageState();

}

class MenuNotesPageState extends State<MenuNotesPage> {
  final _notesBox = Hive.box('notes');

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: 'Mis Notas',
      body: ValueListenableBuilder(
        valueListenable: _notesBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No hay notas aún.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: box.length,
            itemBuilder: (context, index) {
              var note = box.getAt(index);
              return GestureDetector(
                onTap: () => _editNote(context, index, note),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(note, style: const TextStyle(fontSize: 18)),
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
    _notesBox.add('Nueva Nota');
  }

  void _editNote(BuildContext context, int index, String note) {
    TextEditingController controller = TextEditingController(text: note);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Nota'),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                _notesBox.putAt(index, controller.text);
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            )
          ],
        );
      },
    );
  }
}