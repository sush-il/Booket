import 'package:flutter/material.dart';
import 'package:booket/manageDB.dart';
import 'package:booket/pages/models/dbmodels.dart';

class EditBook extends StatefulWidget {
  final Book? book;
  const EditBook({super.key, required this.book});

  @override
  State<EditBook> createState() => _EditBook();
}

class _EditBook extends State<EditBook> {
  final _formKey = GlobalKey<FormState>();

  late Book data;

  @override
  void initState() {
    super.initState();
    data = widget.book!;
  }

  @override
  Widget build(BuildContext context) {
    String? updatedBook = data.title;
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
                    TextFormField(
                      //Text Fields
                      maxLines: 3,
                      minLines: 1,
                      controller: TextEditingController(text: updatedBook),
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
                        setState(() => updatedBook = value);
                        data.title = updatedBook;
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

                              BooksDatabase.instance.updateBook(data);

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
