import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class InventoryDB {
  static InventoryDB _db = new InventoryDB._internal();
  static InventoryDB get instace => _db;
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _init();
    return _database!;
  }

  InventoryDB._internal();

  Future<Database> _init() async {
    return await openDatabase(
      version: 5,
      join(await getDatabasesPath(), "inventory_database.db"),
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE Category(categoryId INTEGER PRIMARY KEY, categoryName TEXT, status INTEGER)");
        db.execute(
            "CREATE TABLE Product(productId INTEGER PRIMARY KEY, quantity INTEGER,productName TEXT, status INTEGER,description TEXT, price REAL, salePrice REAL, categoryId INTEGER, FOREIGN KEY(categoryId) REFERENCES Category(categoryId))");
        db.execute(
            "Create TABLE ProductImage(productImageId INTEGER PRIMARY KEY, urlImage TEXT, productId INTEGER,FOREIGN KEY(productId) REFERENCES Product(productId))");
        db.execute(
            "CREATE TABLE MoneyFlow(moneyFlowId INTEGER PRIMARY KEY, flowType INTEGER,amount REAL, quantity INTEGER, date INTEGER,productId INTEGER, FOREIGN KEY(productId) REFERENCES Product(productId))");
      },
    );
  }
}
