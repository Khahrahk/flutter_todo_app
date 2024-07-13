import 'package:flutter/material.dart';
import 'package:flutter_todo_app/resources/views/notes/index.dart';
import 'package:flutter_todo_app/resources/views/themes/index.dart';

Function sideMenu = (BuildContext context) {
  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      )
    ),
  );  
};

Widget buildHeader(BuildContext context) => Container(
  padding: EdgeInsets.only(
    top: MediaQuery.of(context).padding.top,
  ),
);

Widget buildMenuItems(BuildContext context) => Container(
  padding: const EdgeInsets.all(12),
  child: Wrap(
    runSpacing: 2,
    children: [
      ListTile(
        leading: const Icon(Icons.home_outlined),
        title: const Text('Notes'),
        onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NotesView(filterValues: [0, 0], filterQuery: 'complete = ? and softDelete = ?'))),
      ),
      const Divider(color: Colors.black54),
      ListTile(
        leading: const Icon(Icons.favorite_border),
        title: const Text('Favourites'),
        onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NotesView(filterValues: [1, 0], filterQuery: 'favourite = ? and softDelete = ?'))),
      ),
      ListTile(
        leading: const Icon(Icons.delete_outline),
        title: const Text('Deleted'),
        onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NotesView(filterValues: [1], filterQuery: 'softDelete = ?'))),
      ),
      ListTile(
        leading: const Icon(Icons.task_outlined),
        title: const Text('Completed'),
        onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NotesView(filterValues: [1, 0], filterQuery: 'complete = ? and softDelete = ?'))),
      ),
      ListTile(
        leading: const Icon(Icons.workspaces_outline),
        title: const Text('Themes'),
        onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MultipleThemesView())),
      ),
    ]
  )
);