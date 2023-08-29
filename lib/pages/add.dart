import 'package:booket/manageDB.dart';
import 'package:flutter/material.dart';
import 'package:booket/pages/models/dbmodels.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final booksDB = BooksDatabase.instance;
  //final notesDB = NotesDatabase;

  String? bookTitle = "";
  String? bookNote = "";

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            //Padding
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(
              //Column
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  //Text Fields
                  maxLines: 3,
                  minLines: 1,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(25),
                    border: InputBorder.none,
                    icon: Icon(Icons.book_rounded),
                    hintText: 'Book Title',
                  ),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                  onSaved: (String? value) {
                    // This optional block of code can be used to run code when the user saves the form.
                    setState(() => bookTitle = value);
                  },
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter some text'
                        : null;
                  },
                ),

                /////////////////////////////

                TextFormField(
                  maxLines: 10,
                  minLines: 1,
                  decoration: const InputDecoration(
                    //icon: Icon(Icons.description_rounded),
                    contentPadding: EdgeInsets.all(12),
                    border: InputBorder.none,
                    hintText: 'My book Notes.',
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  onSaved: (String? value) {
                    // This optional block of code can be used to run code when the user saves the form.
                    setState(() => bookNote = value);
                  },
                  validator: (String? value) {
                    return (value == null || value.isEmpty)
                        ? 'Please enter some text.'
                        : null;
                  },
                ),

                /////////// Button //////////////

                Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Theme.of(context).colorScheme.tertiary),
                          foregroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.black)),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context)
                              .unfocus(); //Dropdown the keyboard after saving
                          _formKey.currentState?.save();

                          booksDB.addBook(Book(title: bookTitle)).then(
                              (addedBook) => NotesDatabase().addNote(
                                  Note(note: bookNote, bookID: addedBook.id)));

                          // If the form is valid, display a snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Saving...")),
                          );
                        }
                      },
                      child: const Text('Save'),
                    )),
              ],
            ))));
  }
}
