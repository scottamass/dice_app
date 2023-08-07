import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('D20'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int diceNo = 1;

 void rollDice() async {
  setState(() {
    diceNo = 21;
    print('roll');
  });

  await Future.delayed(Duration(seconds: 1));

  setState(() {
    diceNo = Random().nextInt(6) + 1; // 1-6
  });
}


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                rollDice();
              },
              child: Image.asset('images/dice$diceNo.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
