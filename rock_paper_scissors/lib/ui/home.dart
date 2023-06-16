import 'package:flutter/material.dart';
import 'dart:math';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List _images = ["rock", "paper", "scissors", "question"];
  List _messages = [
    "Pick one to play",
    "You win! Pick one to play again",
    "You lose! Pick one to play again",
    "Tie! Pick one to play again"
  ];
  List _colors = [Colors.grey, Colors.green, Colors.red];
  int _index = 3;
  int _messageIndex = 0;
  int _colorIndex = 0;
  int _correct = 0;
  String topText = "Let's play!";

  // Initial state of the application
  @override
  void initState() {
    super.initState();
    // Generate a new initial correct answer when application is first launched
    Random _random = Random();
    _correct = _random.nextInt(3);
    debugPrint("${_images[_correct]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Rock, Paper, Scissors!"),
          centerTitle: true,
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                topText,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Image.asset(
                  "images/" + _images[_index] + ".png",
                  width: 250,
                  height: 250,
                ),
              ),
            ),
            Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: _colors[_colorIndex]),
                  color: _colors[_colorIndex]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _messages[_messageIndex],
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 50), backgroundColor: Colors.red),
                  onPressed: () => _checkWinner(0),
                  child: Text("Rock", style: TextStyle(fontSize: 24.0))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 50), backgroundColor: Colors.green),
                  onPressed: () => _checkWinner(1),
                  child: Text("Paper", style: TextStyle(fontSize: 24.0))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 50), backgroundColor: Colors.blue),
                  onPressed: () => _checkWinner(2),
                  child: Text(
                    "Scissors",
                    style: TextStyle(fontSize: 24.0),
                  )),
            ),
            Spacer(),
          ],
        )));
  }

  _checkWinner(int answer) {
    setState(() {
      topText = "I choose...";
      // Tie
      if (answer == _correct) {
        _colorIndex = 0;
        _messageIndex = 3;
      }
      // Player wins
      else if (answer == 0 && _correct == 2 || // Rock beats paper
          answer == 1 && _correct == 0 || // Paper beats rock
          answer == 2 && _correct == 1) // Scissors beat paper
      {
        _colorIndex = 1;
        _messageIndex = 1;
      }
      // Player looses
      else {
        _colorIndex = 2;
        _messageIndex = 2;
      }

      _index = _correct;
      _generateNewCorrect();
      // debugPrint("${_images[_correct]}");
    });
  }

  _generateNewCorrect() {
    setState(() {
      Random _random = Random();
      _correct = _random.nextInt(3);
    });
  }
}
