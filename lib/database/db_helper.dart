import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // Create singleton pattern for accessing the database
  static Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

  // Initialize the database
  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'inventory.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      // Create table with 5 columns
      db.execute('''
        CREATE TABLE inventory(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          description TEXT,
          quantity INTEGER,
          price REAL
        )
      ''');
    });
  }

  // Insert item into the table
  static Future<void> insertItem(Map<String, dynamic> item) async {
    final db = await getDatabase();
    await db.insert('inventory', item, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Retrieve all items from the inventory
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await getDatabase();
    return await db.query('inventory');
  }

  // Update item in the table
  static Future<void> updateItem(Map<String, dynamic> item) async {
    final db = await getDatabase();
    await db.update(
      'inventory',
      item,
      where: 'id = ?',
      whereArgs: [item['id']],
    );
  }

  // Delete an item from the table
  static Future<void> deleteItem(int id) async {
    final db = await getDatabase();
    await db.delete(
      'inventory',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
