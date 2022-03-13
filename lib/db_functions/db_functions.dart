import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLiteDB {

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE weight_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        user REAL NOT NULL,
        inputted_weight REAL NOT NULL,
        date_inputted TIMESTAMP NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
      """);
    await database.execute("""CREATE TABLE calorie_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        user REAL NOT NULL,
        inputted_calories REAL NOT NULL,
        date_inputted TIMESTAMP NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );""");

    await database.execute("""CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        weight_preference TEXT,
        current_weight REAL,
        targets_enabled INT
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );""");
    await database.execute("""CREATE TABLE strength_records(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        inputted_weight REAL,
        exercise TEXT,
        date_inputted TIMESTAMP NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );""");
  }
  static Future<sql.Database> sqLitedb() async {
    return sql.openDatabase(
      'sql_liteEeeedeeseserdeSDaD.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static createUserInstance() async {
    final db = await SQLiteDB.sqLitedb();

    final data = {'weight_preference': 'KG',
                  'targets_enabled': 0};

    await db.insert('user', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  // Read all items weight
  static Future<List<Map<String, dynamic>>> getUserData() async {
    final db = await sqLitedb();
    return db.query('user', orderBy: "id");
  }

  static returnWeightPreference() async {

  }

  static updateTargetsOption(newValue) async {
    final db = await sqLitedb();

    final data = {'targets_enabled': newValue};
    await db.update('user', data, where: "id = ?", whereArgs: [1]);
  }

  static updateWeightPreference(newValue) async {
    final db = await sqLitedb();
    final data = {'weight_preference': newValue};
    await db.update('user', data, where: "id = ?", whereArgs: [1]);
  }

  static returnFormattedWeightPreference (){
    return 0;
  }

  // Read all items weight
  static Future<List<Map<String, dynamic>>> getWeightData() async {
    final db = await sqLitedb();
    return db.query('weight_entries', orderBy: "date_inputted");
  }

  static Future<List<Map<String, dynamic>>> getCalorieData() async {
    final db = await sqLitedb();
    return db.query('calorie_entries', orderBy: "date_inputted");
  }

  static Future<List<Map<String, dynamic>>> rawSQLQuery(query) async {
    final db = await sqLitedb();
    return db.rawQuery(query);
  }

  // Create new item (weight)
  static Future<int> createNewWeightEntry(user, inputtedWeight, inputtedDate) async {
    final db = await SQLiteDB.sqLitedb();

    final data = {'user': user, 'inputted_weight': inputtedWeight,
                  'date_inputted': inputtedDate.toString()};

    final id = await db.insert('weight_entries', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  // Create new item (Calories)
  static Future<int> createNewCalorieEntry(user, inputtedCalories, inputtedDate) async {
    final db = await SQLiteDB.sqLitedb();

    final data = {'user': user, 'inputted_calories': inputtedCalories,
      'date_inputted': inputtedDate.toString()};

    final id = await db.insert('calorie_entries', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Delete (Weight)
  static Future<void> deleteWeightEntry(int id) async {
    final db = await SQLiteDB.sqLitedb();
    try {
      await db.delete("weight_entries", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
  // Delete (Calorie)
  static Future<void> deleteCalorieEntry(int id) async {
    final db = await SQLiteDB.sqLitedb();
    try {
      await db.delete("calorie_entries", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

}