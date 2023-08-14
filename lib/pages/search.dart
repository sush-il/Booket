import 'package:flutter/material.dart';
import 'package:booket/manageDB.dart';
import 'package:booket/pages/models/dbmodels.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                displayBooks();
              },
              child: const Text('Button'))),
    );
  }

  void displayBooks() async {
    List<Book> books = await BooksDatabase.instance.readAllBooks();
    List<Note> notes = await NotesDatabase().readAllNotes();

    for (var book in books) {
      print(book.title);
    }

    for (var note in notes) {
      print(note.note);
    }

    print(await BooksDatabase.instance.getDbLength());
  }
}
