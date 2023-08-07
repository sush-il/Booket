import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:booket/booksdb.dart';
import 'package:booket/pages/models/dbmodels.dart';

final pages = [
  Container(
    color: Colors.black,
    child: const Center(child: Text('Page 1')),
  ),
  Container(
    color: Colors.red,
    child: const Center(child: Text('Page 2')),
  ),
  Container(
    color: Colors.blue,
    child: const Center(child: Text('Page 3')),
  ),
];

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
          return LiquidSwipe(pages: pages);
        });

    //return LiquidSwipe(pages: BuildPage().buildPage());
  }
}

class BuildPage {
  Future<List<Widget>> buildPage() async {
    //Generate a random color
    String bookTitle = await displayBooks();

    return [
      Container(
        color: generateRandomColor(),
        child: Center(child: Text(bookTitle)),
      )
    ];
  }

  Future<String> displayBooks() async {
    int bookId = await getRandomBookId();
    Book book = await BooksDatabase.instance.readBook(bookId);
    return book.title ?? '';
  }

  Future getRandomBookId() async {
    int dbLength = await BooksDatabase.instance.getDbLength() - 1;
    Random random = Random();
    return random.nextInt(dbLength);
  }

  Color generateRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1,
    );
  }
}


//Original working class
/* 
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: LiquidSwipe(pages: pages),
      bottomNavigationBar: const BottomNavbar(),
    ));
  }
}*/