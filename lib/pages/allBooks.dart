import 'package:booket/pages/allNotes.dart';
import 'package:booket/pages/editBook.dart';
import 'package:flutter/material.dart';
import 'package:booket/manageDB.dart';
import 'package:booket/pages/models/dbmodels.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: FutureBuilder<List<Widget>>(
              future: showBooks(),
              builder: ((context, snapshot) => Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(20),
                  child: ListView(children: snapshot.data!))),
            )));
  }

  Future<List<Widget>> showBooks() async {
    List<Widget> noteCards = [
      Container(
          alignment: Alignment.bottomLeft,
          child: const Text(
            "Books",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ))
    ];
    List<Book> books = await BooksDatabase.instance.readAllBooks();
    for (var book in books) {
      noteCards.add(Container(
        alignment: Alignment.bottomLeft,
        margin: const EdgeInsets.all(5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  Future<List<Note>> bookNotes =
                      NotesDatabase().getBookNotes(book.id!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotesPage(
                          bookNotes: bookNotes,
                        ),
                      ));
                },
                child: Text(
                  book.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditBook(book: book)));
                },
                child: const Text("Edit")),
            TextButton(
                onPressed: () {
                  NotesDatabase().deleteWhereBookID(book.id!);
                  BooksDatabase.instance.deleteBook(book.id!);
                },
                child: const Text("Delete")),
          ])
        ]),
      ));
    }
    return noteCards;
  }

  Future<String> getBookName(int bookID) async {
    Book book = await BooksDatabase.instance.readBook(bookID);
    return book.title!;
  }
}
