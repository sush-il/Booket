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
            //enableSideReveal: true,
            positionSlideIcon: 0.5,
          );
        });
  }
}

/* Class builds a page for liquid swipe */
class BuildPage {
  Future<List<Widget>> buildPage() async {
    //get a random book
    List<Note> bookNotes = await getNotes();
    List<Widget> booksInfo = [];
    //Generate a page using each book title
    for (var bookNote in bookNotes) {
      booksInfo.add(Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: generateRandomColor(), fit: BoxFit.cover)),
        //color: generateRandomColor(),
        padding: const EdgeInsets.all(10),
        child: Center(
            child: RichText(
          text: TextSpan(
              text: "'${bookNote.note}'",
              style: TextStyle(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        color: Colors.black.withOpacity(1.0),
                        offset: const Offset(2, 2),
                        blurRadius: 5.0),
                  ],
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
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

  //Returns a random note ID from all Notes
  Future getRandomNoteId() async {
    List<int> allIDs = await NotesDatabase().getAllNoteIDs();
    Random random = Random();
    return allIDs[random.nextInt(allIDs.length)];
  }

  AssetImage generateRandomColor() {
    Random random = Random();
    List<AssetImage> images = const [
      AssetImage("assets/images/wall01.jpg"),
      AssetImage("assets/images/wall02.jpg"),
      AssetImage("assets/images/wall03.jpg"),
      AssetImage("assets/images/wall04.jpg"),
      AssetImage("assets/images/wall05.jpg"),
      AssetImage("assets/images/wall06.jpg"),
      AssetImage("assets/images/wall07.jpg"),
      AssetImage("assets/images/wall08.jpg"),
      AssetImage("assets/images/wall09.jpg"),
      AssetImage("assets/images/wall10.jpg"),
      AssetImage("assets/images/wall11.jpg")
    ];
    return images[random.nextInt(images.length)];
  }

  //gets the name of the book from bookID
  Future<String> getBookName(int bookID) async {
    Book book = await BooksDatabase.instance.readBook(bookID);
    return book.title!;
  }
}
