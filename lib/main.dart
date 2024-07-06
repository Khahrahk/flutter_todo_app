import 'package:flutter/material.dart';
import 'resources/views/notes/index.dart';

void main() {
  // if (Platform.isWindows || Platform.isLinux) {
  //   sqfliteFfiInit();
  // }
  // databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter notes example app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotesView(),
    );
  }
}