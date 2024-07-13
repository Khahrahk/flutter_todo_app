import '../Models/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Notes.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
          "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL, complete INTEGER, softDelete INTEGER, favourite INTEGER);"),
          version: _version
        );
  }

  static Future<int> addNote(Note note) async {
    final db = await _getDB();
    return await db.insert("Note", note.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(Note note) async {
    final db = await _getDB();
    return await db.update("Note", note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> completeNote(Note note, int complete) async {
    final db = await _getDB();
    var finalNote = Note(id: note.id, title: note.title, description: note.description, complete: complete);
    return await db.update("Note", finalNote.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> favouriteNote(Note note, int favourite) async {
    final db = await _getDB();
    var finalNote = Note(id: note.id, title: note.title, description: note.description, favourite: favourite);
    return await db.update("Note", finalNote.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> softDeleteNote(Note note, int softDelete) async {
    final db = await _getDB();
    var finalNote = Note(id: note.id, title: note.title, description: note.description, softDelete: softDelete);
    return await db.update("Note", finalNote.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> deleteNote(Note note) async {
    final db = await _getDB();
    return await db.delete(
      "Note",
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<List<Note>?> getAllNotes(String filterQuery, List<Object?> filterValues) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Note", where: filterQuery, whereArgs: filterValues);
    if (maps.isEmpty) return null;

    return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  }
}
