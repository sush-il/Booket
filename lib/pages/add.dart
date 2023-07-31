import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

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
                    // This optional block of code can be used to run
                    // code when the user saves the form.
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
                    // This optional block of code can be used to run
                    // code when the user saves the form.
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
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 35, 239, 208)),
                          foregroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 61, 61, 61))),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Saving...')),
                          );
                        }
                      },
                      child: const Text('Save'),
                    )),
              ],
            ))));
  }
}
