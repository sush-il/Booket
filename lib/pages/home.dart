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
    print("runs here");
    List<Note> bookNotes = await getNotes();
    List<Widget> booksInfo = [];
    //Generate a page using each book title
    for (var bookNote in bookNotes) {
      booksInfo.add(Container(
        color: generateRandomColor(),
        padding: const EdgeInsets.all(10),
        child: Center(
            child: RichText(
          text: TextSpan(
              text: "'${bookNote.note}'",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
              children: <TextSpan>[
                TextSpan(
                    text: "\n- ${await getBookName(bookNote.bookID!)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromARGB(255, 185, 185, 185))),
              ]),
        )),
      ));
    }
    print("books info");
    print(booksInfo);
    return booksInfo;
  }

  // Grab a random note from the database
  Future<List<Note>> getNotes() async {
    List<Note> bookNotes = [];

    for (int i = 0; i < 5; i++) {
      int noteID = await getRandomNoteId();
      Note note = await NotesDatabase().readNote(noteID);
      bookNotes.add(note);
    }

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

  //gets the name of the book from bookID
  Future<String> getBookName(int bookID) async {
    Book book = await BooksDatabase.instance.readBook(bookID);
    return book.title!;
  }
}
