//import 'dart:js_util';
import 'package:booket/pages/models/dbmodels.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BooksDatabase {
  static final BooksDatabase instance = BooksDatabase._init();
  static Database? _db;
  BooksDatabase._init();

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB('books.db');
    return _db!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    //final path = join(dbPath, dbName);
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $booksTable(
        ${BookFields.id} $idType,
        ${BookFields.title} $textType
      )''');
  }

  Future<Book> addBook(Book book) async {
    final db = await instance.database;
    final id = await db.insert(booksTable, book.toJson());
    return book.copy(id: id);
  }

  Future<Book> readBook(int id) async {
    final db = await instance.database;

    final item = await db.query(booksTable,
        columns: BookFields.values,
        where: '${BookFields.id} = ?',
        whereArgs: [id]);

    if (item.isNotEmpty) {
      return Book.fromJson(item.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Book>> readAllBooks() async {
    final db = await instance.database;
    //final orderBy = '${BookFields.id} ASC';
    final result = await db.query(booksTable);
    return result.map((json) => Book.fromJson(json)).toList();
  }

  Future<int> updateBook(Book book) async {
    final db = await instance.database;
    return db.update(
      booksTable,
      book.toJson(),
      where: '${BookFields.id} = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    final db = await instance.database;
    return db
        .delete(booksTable, where: '${BookFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future getDbLength() async {
    final db = await instance.database;
    int? count = Sqflite.firstIntValue(
        await db.rawQuery('''SELECT COUNT(*) FROM books'''));
    return count;
  }
}
