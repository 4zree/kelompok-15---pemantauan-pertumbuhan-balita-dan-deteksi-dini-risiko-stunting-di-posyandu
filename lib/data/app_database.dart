import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../models/child.dart';

/// SQLite database stored locally on the Android device.
class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();
  static const _databaseName = 'kadercek.db';
  static const _databaseVersion = 1;
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    final databasePath = await getDatabasesPath();
    _database = await openDatabase(
      p.join(databasePath, _databaseName),
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE children (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          gender TEXT NOT NULL CHECK (gender IN ('L', 'P')),
          birth_date TEXT NOT NULL,
          created_at TEXT NOT NULL
        )''');
        await db.execute('CREATE INDEX idx_children_name ON children(name)');
      },
    );
    return _database!;
  }

  Future<List<Child>> getChildren({String query = ''}) async {
    final db = await database;
    final q = query.trim();
    final rows = await db.query('children', where: q.isEmpty ? null : 'name LIKE ?', whereArgs: q.isEmpty ? null : ['%$q%'], orderBy: 'name COLLATE NOCASE ASC');
    return rows.map(Child.fromMap).toList();
  }

  Future<int> insertChild(Child child) async {
    final values = child.toMap()..remove('id');
    return (await database).insert('children', values);
  }

  Future<int> updateChild(Child child) async {
    if (child.id == null) throw ArgumentError('ID balita tidak tersedia.');
    final values = child.toMap()..remove('id');
    return (await database).update('children', values, where: 'id = ?', whereArgs: [child.id]);
  }

  Future<int> deleteChild(int id) async => (await database).delete('children', where: 'id = ?', whereArgs: [id]);
}
