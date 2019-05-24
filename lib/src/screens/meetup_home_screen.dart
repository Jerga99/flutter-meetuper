
import 'dart:math';

import 'package:flutter/material.dart';



class MeetupHomeScreen extends StatefulWidget {
  MeetupHomeScreenState createState() => MeetupHomeScreenState();
}

class MeetupHomeScreenState extends State<MeetupHomeScreen> {
  List<CustomText> customTextList = [CustomText(name: '1'), CustomText(name: '2'), CustomText(name: '3')];

  _shuffleList() {
    setState(() {
      customTextList.shuffle();
      customTextList.forEach((e) => print(e.name));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: customTextList,
      ),
      appBar: AppBar(
        title: Text('Home')
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _shuffleList,
      ),
    );
  }
}


class CustomText extends StatefulWidget {
  final String name;

  CustomText({this.name});

  @override
  CustomTextState createState() => CustomTextState();
}

class CustomTextState extends State<CustomText> {
  List colors = [Colors.red, Colors.blue, Colors.brown, Colors.orange, Colors.grey, Colors.deepPurple];
  Random random = Random();
  Color color;

  initState() {
    super.initState();
    color = colors[random.nextInt(colors.length)];
  }


  Widget build(BuildContext context) {
    return Container(
      child: Text('Custom Text of $color'),
      color: color,
      height: 150.0
    );
  }
}










