import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(Icons.home_rounded)),
          BottomNavigationBarItem(
              label: 'Add', icon: Icon(Icons.add_box_rounded)),
          BottomNavigationBarItem(
              label: 'Search', icon: Icon(Icons.search_rounded)),
          BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.person)),
        ]);
  }
}
