import 'package:flutter/material.dart';
import 'resources/views/notes/index.dart';
import 'app/Controllers/ThemeController.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'themes.dart';

Future main() async {
  setupLocator();
  await ThemeManager.initialise();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.system,
            darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.grey[300],
          brightness: Brightness.dark,
          secondary: Colors.grey[100],
        ),
      ),
      lightTheme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.grey[300],
          brightness: Brightness.light,
          secondary: Colors.grey[100],
        ),
      ),
      themes: getThemes(),
      statusBarColorBuilder: (theme) => theme?.colorScheme.secondary,
      navigationBarColorBuilder: (theme) => theme?.colorScheme.secondary,
      builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
        title: 'Flutter notes example app',
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: const NotesView(filterValues: [0, 0], filterQuery: 'complete = ? AND softDelete = ?'),
      )
    );
  }
}