import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/blocs/user_bloc/states.dart';

class BottomNavigation extends StatefulWidget {

  final Function(int) onChange;
  final UserState userState;

  BottomNavigation({@required this.onChange, @required this.userState});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}


class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  _handleTap(int index) {
    setState((){
      _currentIndex = index;
      widget.onChange(index);
    });
  }

  _renderColor() {
    return (widget.userState is UserIsMember || widget.userState is UserIsMeetupOwner) ? null : Colors.black12;
  }

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _handleTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home
          ),
          title: Text('Detail')
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.note,
            color: _renderColor()),
          title: Text('Threads', style: TextStyle(color: _renderColor()))
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people,
            color: _renderColor()),
          title: Text('People', style: TextStyle(color: _renderColor()))
        )
      ]
    );
  }
}
