import 'package:booket/pages/models/allNotes.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          margin: const EdgeInsets.only(top: 40, left: 10),
          child: const Text(
            "Browse",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),

        Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.all(15),
            child: const Column(children: [
              SearchBar(
                hintText: "Search...",
              )
            ])),

        Container(
          margin: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            "YOUR CONTENT",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey),
          ),
        ),

        //Books Button
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            child: ElevatedButton.icon(
                icon: const Icon(Icons.book_rounded),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  minimumSize: Size(screenWidth * 0.85, 50.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  displayBooks();
                },
                label: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Your Books',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ]))),

        //Notes Button
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            child: ElevatedButton.icon(
                icon: const Icon(Icons.notes_rounded),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  minimumSize: Size(screenWidth * 0.35, 50.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotesPage()));
                },
                label: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Your Notes',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ]))),
      ]),
    );
  }

  void displayBooks() async {
    List<Book> books = await BooksDatabase.instance.readAllBooks();

    for (var book in books) {
      print(book.title);
    }
  }

  void displayNotes() async {
    List<Note> notes = await NotesDatabase().readAllNotes();
    for (var note in notes) {
      print(note.note);
    }
  }
}
