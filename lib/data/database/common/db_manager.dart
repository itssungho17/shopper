import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static final DBManager _instance = DBManager._internal();
  factory DBManager() => _instance;

  DBManager._internal();

  Future<Database> get database async {
    return openDatabase(
      join(await getDatabasesPath(), 'shopper.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE products(id INTEGER PRIMARY KEY, title TEXT, description TEXT, price INTEGER, discountPercentage REAL, rating REAL, stock INTEGER, brand TEXT, category TEXT, thumbnail TEXT, images TEXT)",
        );
      },
      version: 1,
    );
  }

}
