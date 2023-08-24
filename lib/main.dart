import 'package:booket/navbar.dart';
import 'package:booket/pages/add.dart';
import 'package:booket/pages/search.dart';
import 'package:booket/pages/settings.dart';
import 'package:booket/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
        initialRoute: "/home",
        routes: {
          "/": (context) => LoginPage(),
          "/home": (context) => const BottomNavbar(), //const HomePage(),
          //"/login": (context) => LoginPage(),
          "/settings": (context) => const SettingsPage(),
          "/search": (context) => const SearchPage(),
          "/add": (context) => const AddPage()
        });
  }
}
