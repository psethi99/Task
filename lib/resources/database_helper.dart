import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'user.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user(first_name TEXT, last_name TEXT, email TEXT, mobile TEXT, is_upload INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelper.database();
    return db.query('user');
  }
}
