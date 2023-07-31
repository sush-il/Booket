import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

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
    return LiquidSwipe(pages: pages);
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