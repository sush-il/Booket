import 'package:flutter/material.dart';
import 'package:booket/manageDB.dart';
import 'package:booket/pages/models/dbmodels.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: FutureBuilder<List<Widget>>(
              future: showNotes(),
              builder: ((context, snapshot) => (Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(20),
                  child: Column(children: snapshot.data!)))),
            )));
  }

  Future<List<Widget>> showNotes() async {
    List<Widget> noteCards = [
      const Text(
        "Notes",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      )
    ];
    List<Note> notes = await NotesDatabase().readAllNotes();
    for (var note in notes) {
      noteCards.add(Container(
        alignment: Alignment.bottomLeft,
        //decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5.0),
        child: RichText(
          text: TextSpan(
              text: note.note,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              children: <TextSpan>[
                TextSpan(
                    text: "\n- ${await getBookName(note.bookID!)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey)),
              ]),
        ),
      ));
      //getBookName(note.bookID!).then((value) => {print(value)});
    }
    return noteCards;
  }

  Future<String> getBookName(int bookID) async {
    Book book = await BooksDatabase.instance.readBook(bookID);
    return book.title!;
  }
}
