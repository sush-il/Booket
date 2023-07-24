import 'package:booket/navbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String btnName = 'Button';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
          onPressed: () {
            setState(() {
              btnName = 'Clicked';
            });
          },
          child: Text(btnName),
        )),
        bottomNavigationBar: BottomNavbar());
  }
}
