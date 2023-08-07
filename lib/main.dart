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
  bool multipleDiceMode = false; // New variable to track the mode

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

  void toggleDiceMode() {
    setState(() {
      multipleDiceMode = !multipleDiceMode;
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
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              'Your last roll was: $previousRoll',
              style: TextStyle(fontSize: 20),
            ),
          ),
          if (multipleDiceMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 2; i++) // Display two dice
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      onPressed: () {
                        rollDice();
                      },
                      child: Image.asset('images/dice$diceNo.jpg'),
                    ),
                  ),
              ],
            )
          else
            TextButton(
              onPressed: () {
                rollDice();
              },
              child: Image.asset('images/dice$diceNo.jpg'),
            ),
          ElevatedButton(
            onPressed: () {
              toggleDiceMode();
            },
            child: Text(multipleDiceMode ? 'Single Die' : 'Multiple Dice'),
          ),
        ],
      ),
    );
  }
}
