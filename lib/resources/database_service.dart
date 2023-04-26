import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _singleton = DatabaseService._internal();

  static DatabaseService get instance => _singleton;

  Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null we instantiate it
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'my_database.db');

    // Open the database. Can also add more options to configure the database.
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Run the CREATE TABLE statement here
        return db.execute(
          '''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            first_name TEXT NOT NULL,
            last_name TEXT NOT NULL,
            email TEXT NOT NULL,
            mobile TEXT NOT NULL,
            is_upload INTEGER DEFAULT 0
          )
          ''',
        );
      },
    );

    return database;
  }

  Future<int> insertUser({
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    int isUpload = 0,
  }) async {
    final db = await database;

    final values = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'is_upload': isUpload,
    };

    return await db.insert('users', values);
  }

  Future<List<Map<String, dynamic>>> getUsers({int isUpload = 0}) async {
    final db = await database;
    return await db.query('users', where: 'is_upload = ?', whereArgs: [isUpload]);
  }

  Future<int> updateUploadStatus({required int id, required int isUpload}) async {
    final db = await database;

    final values = {
      'is_upload': isUpload,
    };

    return await db.update('users', values, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteUsers() async {
    final db = await database;
    await db.delete('users');
  }
}
