import 'package:shopper/data/common/data_source.dart';
import 'package:shopper/data/database/common/db_manager.dart';
import 'package:shopper/data/models/shop/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductDB implements DataSource<Product> {

  final _database = DBManager().database;

  @override
  Future<Product> addOne(Product item) async {
    final Database db = await _database;
    await db.insert(
      'products',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return item;
  }

  @override
  Future<Product> deleteOne(Product item) async {
    final Database db = await _database;
    await db.delete(
      'products',
      where: "id = ?",
      whereArgs: [item.id],
    );
    return item;
  }

  @override
  Future<List<Product>> getAll() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return ProductExtensions.fromMap(maps[i]);
    });
  }

  @override
  Future<Product> getOne(String key) async {
    final Database db = await _database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: "id = ?",
      whereArgs: [key],
    );
    return ProductExtensions.fromMap(maps.first);
  }

  @override
  Future<Product> updateOne(Product item) async {
    final Database db = await _database;
    await db.update(
      'products',
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );
    return item;
  }
}
