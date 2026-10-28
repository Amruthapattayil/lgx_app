import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? db;

  Future<Database> get database async {
    if (db != null) {
      return db!;
    }

    String folder = await getDatabasesPath();
    String path = join(folder, 'notes.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE notes ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'title TEXT NOT NULL, '
          'body TEXT NOT NULL, '
          'created_at TEXT NOT NULL'
          ')',
        );
      },
    );

    return db!;
  }

  // CREATE: Save a note
  Future<int> insertNote(Map<String, dynamic> note) async {
    final database = await this.database;
    return database.insert('notes', note);
  }

  // READ: Get all notes
  Future<List<Map<String, dynamic>>> getNotes() async {
    final database = await this.database;
    return database.query('notes');
  }

  // UPDATE: Edit a note
  Future<int> updateNote(int id, Map<String, dynamic> note) async {
    final database = await this.database;

    return database.update(
      'notes',
      note,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE: Remove a note
  Future<int> deleteNote(int id) async {
    final database = await this.database;

    return database.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}