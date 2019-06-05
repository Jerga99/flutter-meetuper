import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {

  final Function(int) onChange;

  BottomNavigation({@required this.onChange});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}


class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) => setState((){
         _currentIndex = index;
         widget.onChange(index);
      }),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Detail')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          title: Text('Threads')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          title: Text('People')
        )
      ]
    );
  }
}
