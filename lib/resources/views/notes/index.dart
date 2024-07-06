import 'dart:io';

import 'package:flutter/material.dart';

import '../../../app/Models/Note.dart';
import '../../../app/Controllers/NoteController.dart';
import '../../widgets/note_widget.dart';
import 'show.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Notes'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NoteView()));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Note>?>(
          future: DatabaseHelper.getAllNotes(),
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
                        DatabaseHelper.deleteNote(note);
                      },
                      child: NoteWidget(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoteView(
                                    note: snapshot.data![index],
                                  )));
                          setState(() {});
                        },
                        onLongPress: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Are you sure you want to delete this note?'),
                                  actions: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                          WidgetStateProperty.all(
                                              Colors.red)),
                                      onPressed: () async {
                                        // stderr.writeln('print me');
                                        await DatabaseHelper.deleteNote(
                                            snapshot.data![index]);
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
                        }, note: note,
                      ),
                    );
                  }
                );
              }
              return const Center(
                child: Text('No notes yet'),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          )
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
  );

  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () => 
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NotesView())),
        ),
        const Divider(color: Colors.black54),
        ListTile(
          leading: const Icon(Icons.favorite_border),
          title: const Text('Favourites'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.workspaces_outline),
          title: const Text('WorkFlow'),
          onTap: () {},
        ),
      ]
    )
  );
}
