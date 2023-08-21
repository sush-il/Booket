const String booksTable = 'books';
const String notesTable = 'notes';

class BookFields {
  static final List<String> values = [id, title];

  static const String id = '_id';
  static const String title = 'title';
}

class Book {
  final int? id;
  String? title;
  //final DateTime createdTime;

  Book({this.id, required this.title});

  Map<String, Object?> toJson() => {BookFields.id: id, BookFields.title: title};

  static Book fromJson(Map<String, Object?> json) => Book(
        id: json[BookFields.id] as int?,
        title: json[BookFields.title] as String,
      );

  Book copy({
    int? id,
    String? title,
  }) =>
      Book(
        id: id ?? this.id,
        title: title ?? this.title,
      );
}

class NoteFields {
  static final List<String> values = [id, bookID, note];

  static const String id = '_id';
  static const String bookID = 'bookID';
  static const String note = 'note';
}

class Note {
  final int? id;
  final int? bookID;
  String? note;

  Note({this.id, this.bookID, required this.note});

  Map<String, Object?> toJson() =>
      {NoteFields.id: id, NoteFields.bookID: bookID, NoteFields.note: note};

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        bookID: json[NoteFields.bookID] as int?,
        note: json[NoteFields.note] as String,
      );

  Note copy({
    int? id,
    int? bookID,
    String? note,
  }) =>
      Note(
        id: id ?? this.id,
        bookID: bookID ?? this.bookID,
        note: note ?? this.note,
      );
}
