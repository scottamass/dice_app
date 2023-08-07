import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
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
  dynamic previousRoll = '';
  void playSound() async {
    final player = AudioCache();
    player.play('dice.mp3');
  }

  void rollDice() async {
    setState(() {
      previousRoll = diceNo;
      diceNo = 21;
      playSound();
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0), // Add some top padding
            child: Text(
              'Your last roll was: $previousRoll',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    rollDice();
                  },
                  child: Image.asset('images/dice$diceNo.jpg'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
