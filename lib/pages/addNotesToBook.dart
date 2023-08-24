import 'package:flutter/material.dart';
import 'package:booket/manageDB.dart';
import 'package:booket/pages/models/dbmodels.dart';

class AddNote extends StatefulWidget {
  final Book data;
  const AddNote({super.key, required this.data});

  @override
  State<AddNote> createState() => _AddNote();
}

class _AddNote extends State<AddNote> {
  final _formKey = GlobalKey<FormState>();

  late Book book;

  @override
  void initState() {
    super.initState();
    book = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    String? newNote = "";
    return Scaffold(
        body: Form(
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
                    //Title
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Models",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 50),
                        )),

                    //Input Field
                    TextFormField(
                      maxLines: 5,
                      minLines: 1,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(25),
                        border: InputBorder.none,
                        icon: Icon(Icons.notes_rounded),
                        hintText: 'My note',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run code when the user saves the form.
                        setState(() => newNote = value);
                      },
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? 'Please enter some text'
                            : null;
                      },
                    ),

                    /////////// Button //////////////

                    Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color.fromARGB(255, 35, 239, 208)),
                              foregroundColor: MaterialStatePropertyAll<Color>(
                                  Color.fromARGB(255, 61, 61, 61))),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context)
                                  .unfocus(); //Dropdown the keyboard after saving
                              _formKey.currentState?.save();

                              NotesDatabase().addNote(
                                  Note(note: newNote, bookID: book.id));

                              // If the form is valid, display a snackbar.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Saving...")),
                              );
                            }
                          },
                          child: const Text('Save'),
                        )),
                  ],
                )))));
  }
}
