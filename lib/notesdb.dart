import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:booket/pages/models/dbmodels.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  NotesDatabase._init();
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('notes.db');
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
        ${NoteFields.id} $idType,
        ${NoteFields.note} $textType,
        ${NoteFields.bookID} Integer,
        FOREIGN KEY(bookID) REFERENCES books(id)
      )''');
  }

  Future<Note> addNote(Note note) async {
    final db = await instance.database;
    final id = await db.insert(notesTable, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final item = await db.query(notesTable,
        columns: NoteFields.values,
        where: '${NoteFields.id} = ?',
        whereArgs: [id]);

    if (item.isNotEmpty) {
      return Note.fromJson(item.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    //final orderBy = '${BookFields.id} ASC';
    final result = await db.query(booksTable);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> updateNote(Book note) async {
    final db = await instance.database;
    return db.update(
      notesTable,
      note.toJson(),
      where: '${BookFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    return db
        .delete(booksTable, where: '${NoteFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future getDbLength() async {
    final db = await instance.database;
    int? count = Sqflite.firstIntValue(
        await db.rawQuery('''SELECT COUNT(*) FROM notes'''));
    return count;
  }
}
