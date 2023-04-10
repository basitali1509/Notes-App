import 'dart:async';
import 'dart:io';
import 'package:notes_app/Model/db_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'notes_db.db';
  static const _databaseVersion = 1;
  static const table = 'Notes';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnSubtitle = 'subtitle';
  static const columnDescription = 'description';
  static const columnPriority = 'priority';
  DatabaseHelper();
  // DatabaseHelper._pvtConst();
  //
  static final DatabaseHelper db_instance = DatabaseHelper();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    db.execute(
        "CREATE TABLE $table($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnTitle TEXT NOT NULL, $columnSubtitle TEXT NOT NULL, $columnDescription TEXT NOT NULL, $columnPriority INTEGER NOT NULL)");
  }

  Future<Notes> insert(Notes notes) async {
    final db = await database;
    await db.insert(
      table,
      notes.toMap(),
    );
    return notes;
  }

  Future<List<Notes>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return Notes(
          id: maps[i]['id'],
          title: maps[i]['title'],
          subtitle: maps[i]['subtitle'],
          description: maps[i]['description'],
          priority: maps[i]['priority']);
    });
  }

  Future<int> update(Notes notes) async {
    // Get a reference to the database.
    final db = await database;
    return await db.update(
      table,
      notes.toMap(),
      where: '$columnId = ?',
      whereArgs: [notes.id],
    );
  }

  Future<int?> delete(int id) async {
    final db = await database;

    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    var db = await database;
    db.close();
  }
}
