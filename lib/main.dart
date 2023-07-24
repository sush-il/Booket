//import 'package:booket/navbar.dart';
import 'package:booket/pages/home.dart';
import 'package:booket/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        //home: const HomePage(),
        //initialRoute: "/home",
        routes: {
          "/": (context) => LoginPage(),
          "/home": (context) => const HomePage(),
          "/login": (context) => LoginPage(),
        });
  }
}
