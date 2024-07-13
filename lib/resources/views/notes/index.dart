import 'package:flutter/material.dart';
import '../../../app/Models/Note.dart';
import '../../../app/Controllers/NoteController.dart';
import '../../widgets/note_widget.dart';
import '../components/side_menu.dart';
import 'show.dart';

class NotesView extends StatefulWidget {
  final  List<Object?> filterValues;
  final String filterQuery;

  const NotesView({
    super.key,
    required this.filterValues,
    required this.filterQuery,
  });

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: theme.colorScheme.secondary,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.secondary,
        foregroundColor: theme.colorScheme.onPrimary,
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => const NoteView()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: todoList(),
      drawer: sideMenu(context)
    );
  }

  Future longPressedModal(note, index) {
    return showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        title: const Text('Are you sure you want to delete this note?'),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                WidgetStateProperty.all(Colors.red)
              ),
              onPressed: () async {
                await DatabaseHelper.softDeleteNote(note, note.softDelete == 0 ? 1 : 0);
                  Navigator.pop(context);
                  setState(() {});
              },
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
        ],
      );
    });
  }

  Widget todoList(){
    return FutureBuilder<List<Note>?>(
      future: DatabaseHelper.getAllNotes(widget.filterQuery, widget.filterValues),
      builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final note = snapshot.data![index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    snapshot.data?.removeAt(index);
                    DatabaseHelper.completeNote(note, note.complete == 0 ? 1 : 0);
                  },
                  background: Container(
                    color: note.complete == 0 ? const Color.fromARGB(255, 127, 177, 129) : const Color.fromARGB(255, 177, 127, 127),
                  ),
                  child: NoteWidget(
                    onTap: () async {
                      await Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => NoteView(note: snapshot.data![index])
                        )
                      );
                      setState(() {});
                    },
                    onLongPress: () async {
                      longPressedModal(note, index);
                    }, note: note,
                  ),
                );
              }
            );
          }
          return const Center(child: Text('No notes yet'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

