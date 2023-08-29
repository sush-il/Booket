import 'package:booket/pages/add.dart';
import 'package:booket/pages/home.dart';
import 'package:booket/pages/search.dart';
import 'package:booket/pages/settings.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});
  //Create a new state for the navbar
  @override
  State<BottomNavbar> createState() => _BottomNavbar();
}

class _BottomNavbar extends State<BottomNavbar> {
  int _pageIndex = 0;

  final screens = const [HomePage(), AddPage(), SearchPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _pageIndex = index; //Set state to the page index
              });
            },
            currentIndex:
                _pageIndex, //update current index with page index to change page
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Add',
                icon: Icon(Icons.add_box_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Explore',
                icon: Icon(Icons.explore_rounded),
              ),
              /*BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(Icons.settings_rounded),
              ),*/
            ]),
        body: screens.elementAt(_pageIndex));
  }
}
