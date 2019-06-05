import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/blocs/user_bloc/states.dart';



class BottomNavigation extends StatelessWidget {
  final currentIndex;
  final Function(int) onChange;
  final UserState userState;

  BottomNavigation({@required this.onChange,
                    @required this.userState,
                    @required this.currentIndex});

  _handleTap(int index, BuildContext context) {
    if (_canAccess()) {
      onChange(index);
    } else {
      if (index != 0) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('You need to log in and to be member of this meetup!'),
          duration: Duration(seconds: 1)
        ));
      }
    }
  }

  _renderColor() {
    return _canAccess() ? null : Colors.black12;
  }

  bool _canAccess() {
    return userState is UserIsMember || userState is UserIsMeetupOwner;
  }

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) => _handleTap(i, context),
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
