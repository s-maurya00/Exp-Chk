import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../models/item.dart';

class DBHelper {
  static Database? _db;

  static const int _version = 1;
  static const String _dbName = 'expchk';

  static Future<void> initDB() async {
    if (_db != null) {
      print("DB already initialized");
      print("db is $_db");

      return;
    }

    try {
      String _path = '${await getDatabasesPath()}$_dbName.db';

      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, _version) {
          return db.execute(
            "CREATE TABLE $_dbName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "image STRING, "
            "productName STRING, "
            "quantity INTEGER, "
            "purchaseDate STRING, "
            "expiryDate STRING, "
            "notificationId INTEGER, "
            "productBarcode INTEGER)",
          );
        },
      );
    } catch (e) {
      debugPrint("Error in DBHelper.init: ${e.toString()}");
    }
  }

  static Future<int> insert(Item item) async {
    try {
      int id = await _db!.insert(
        _dbName,
        item.toJson(),
        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e) {
      debugPrint("Error in DBHelper.insert: ${e.toString()}");
      return -1;
    }
  }

  static Future<List<Map<String, dynamic>>> query() async {
    try {
      // we will make the query function wait 30 seconds for testing purposes and then return the data using below code:
      // await Future.delayed(const Duration(seconds: 2));

      return await _db!.query(_dbName);
    } catch (e) {
      debugPrint("Error in DBHelper.query: ${e.toString()}");
      return [];
    }
  }

  // not functional yet
  static Future<int> delete(int id) async {
    try {
      return await _db!.delete(_dbName, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Error in DBHelper.delete: ${e.toString()}");
      return -1;
    }
  }

  // // not functional yet
  static Future<int> update(Item item) async {
    try {
      return await _db!.update(
        _dbName,
        item.toJson(),
        where: "id = ?",
        whereArgs: [item.id],
      );
    } catch (e) {
      debugPrint("Error in DBHelper.update: ${e.toString()}");
      return -1;
    }
  }

  // // not functional yet
  // static markConsumed(int id) async {
  //   try {
  //     return await _db!.rawUpdate('''
  //       UPDATE $_dbName
  //       SET notificationId = ?
  //       WHERE id = ?
  //     ''', [0, id]);
  //   } catch (e) {
  //     debugPrint("Error in DBHelper.markConsumed: ${e.toString()}");
  //   }
  // }
}
