import 'package:booket/pages/addNotesToBook.dart';
import 'package:booket/pages/editNote.dart';
import 'package:flutter/material.dart';
import 'package:booket/manageDB.dart';
import 'package:booket/pages/models/dbmodels.dart';

class NotesPage extends StatefulWidget {
  final Future<List<Note>>?
      bookNotes; // Receiving all notes for a specific book

  const NotesPage({super.key, this.bookNotes});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late Future<List<Note>>? notes;
  @override
  void initState() {
    super.initState();
    notes = widget.bookNotes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: FutureBuilder<List<Widget>>(
              future: showNotes(),
              builder: ((context, snapshot) => Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(20),
                  child: ListView(children: snapshot.data!))),
            )));
  }

  Future<List<Widget>> showNotes() async {
    List<Widget> noteCards = [
      Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(bottom: 15),
          child: const Text(
            "NOTES",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ))
    ];

    List<Note> notes = await NotesDatabase().readAllNotes();
    List<Note>? bookNotes = await this.notes;

    if (bookNotes != null) {
      notes = bookNotes;
      Book bookRealtedToNote =
          await BooksDatabase.instance.readBook(notes[0].bookID!);
      noteCards.add(Container(
          child: FloatingActionButton(
        mini: true,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNote(data: bookRealtedToNote)));
        },
      )));
    }

    for (var note in notes) {
      noteCards.add(Container(
        alignment: Alignment.bottomLeft,
        //decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RichText(
                    text: TextSpan(
                        text: note.note,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
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
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditNote(
                                    bookNote: note,
                                  )));
                    },
                    child: const Text("Edit")),
                TextButton(
                    onPressed: () {
                      NotesDatabase().deleteNote(note.id!);
                    },
                    child: const Text("Delete"))
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
