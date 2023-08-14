import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:booket/manageDB.dart';
import 'package:booket/pages/models/dbmodels.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
        future: BuildPage().buildPage(),
        builder: (context, snapshot) {
          List<Widget> pages = snapshot.data!;
          return LiquidSwipe(
            pages: pages,
            enableLoop: true,
            enableSideReveal: true,
            positionSlideIcon: 0.5,
          );
        });
  }
}

/* Class builds a page for liquid swipe */
class BuildPage {
  Future<List<Widget>> buildPage() async {
    //get a random book
    List<String> bookNotes = await getNotes();
    List<Widget> booksInfo = [];
    //Generate a page using each book title
    for (var bookNote in bookNotes) {
      booksInfo.add(Container(
        color: generateRandomColor(),
        child: Center(child: Text(bookNote)),
      ));
    }

    return booksInfo;
  }

  // Grab a random note from the database
  Future<List<String>> getNotes() async {
    List<String> bookNotes = [];

    for (int i = 0; i < 5; i++) {
      int noteID = await getRandomNoteId();
      Note note = await NotesDatabase().readNote(noteID);
      bookNotes.add(note.note ?? "None");
    }
    // ---------- Checks --------------------//

    /*List<Book> books = await BooksDatabase.instance.readAllBooks();
    List<Note> notes = await NotesDatabase().readAllNotes();

    for (var element in books) {
      print(element.title);
    }

    for (var element in notes) {
      print(element.note);
    }*/

    // ------------------------------------- //
    return bookNotes;
  }

  //Generate a random number between 0 - lenth of the book database
  Future getRandomNoteId() async {
    int dbLength = await NotesDatabase().getDbLength();
    Random random = Random();
    return random.nextInt(dbLength) + 1;
  }

  Color generateRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1,
    );
  }
}
