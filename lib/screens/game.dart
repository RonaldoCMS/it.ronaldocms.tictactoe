import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tictactoe/screens/homepage.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  bool turnPlayer = true; //true -> X false -> Y
  String get namePlayer => (turnPlayer) ? "X" : "O";

  Map<int, int> values = {
    0: 0,
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
  };

  int scoreX = 0;
  int scoreO = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/game-background.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 5),
          Expanded(flex: 3, child: _suggestions()),
          const Spacer(flex: 5),
          Expanded(flex: 2, child: score()),
          const Spacer(flex: 5),
          gridGame(),
          stopGame(),
        ],
      ),
    );
  }

  Widget score() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(flex: 45, child: FittedBox(child: Text("X = $scoreX"))),
        Spacer(flex: 10),
        Expanded(flex: 45, child: FittedBox(child: Text("O = $scoreO"))),
      ],
    );
  }

  void onTapPlayer(int index) async {
    if (values[index] == 0) {
      values[index] = (turnPlayer) ? 1 : 2;
      if (winMatch()) {
        await _showDialogWinner();
      } else {
        if (parMatch()) {
          await _showDialogWinner(isPar: true);
        } else {}
        turnPlayer = !turnPlayer;
      }
    }
    setState(() {});
  }

  bool winMatch() {
    int player = (turnPlayer) ? 1 : 2;
    if (values[0] == player && values[1] == player && values[2] == player ||
        values[3] == player && values[4] == player && values[5] == player ||
        values[6] == player && values[7] == player && values[8] == player ||
        values[0] == player && values[3] == player && values[6] == player ||
        values[1] == player && values[4] == player && values[7] == player ||
        values[2] == player && values[5] == player && values[8] == player ||
        values[0] == player && values[4] == player && values[8] == player ||
        values[2] == player && values[4] == player && values[6] == player) {
      return true;
    }
    return false;
  }

  Future<void> _showDialogWinner({bool isPar = false}) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("${isPar ? 'draw' : '$namePlayer win!'}")),
          content: ElevatedButton(
            onPressed: () => restartGame(),
            child: Text("Continue"),
          ),
          elevation: 5,
        );
      },
    );
  }

  void restartGame() {
    setState(() {
      values = {
        0: 0,
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
        7: 0,
        8: 0,
      };
      Navigator.pop(context);
      (turnPlayer) ? scoreX++ : scoreO++;
    });
  }

  Widget _suggestions() {
    String namePlayer = (turnPlayer) ? "X" : "O";
    return FittedBox(child: Text("${namePlayer} Turn"));
  }

  Widget gridGame() {
    return Column(
      children: [
        seriesBox(0, 1, 2),
        divider(),
        seriesBox(3, 4, 5),
        divider(),
        seriesBox(6, 7, 8),
      ],
    );
  }

  Widget divider() => Divider(color: Colors.transparent);

  Widget seriesBox(int val1, int val2, int val3) {
    return Row(
      children: [
        Expanded(flex: 32, child: box(val1)),
        const Spacer(flex: 2),
        Expanded(flex: 32, child: box(val2)),
        const Spacer(flex: 2),
        Expanded(flex: 32, child: box(val3)),
      ],
    );
  }

  Widget box(int val) {
    String text = values[val] == 0
        ? ""
        : values[val] == 1
            ? "X"
            : "O";
    return Container(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: () => onTapPlayer(val),
        child: Text(text, textScaleFactor: 5),
      ),
    );
  }

  Widget stopGame() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(),
        Container(
          height: 75,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false),
            child: const Text(
              "Exit",
              textScaleFactor: 2,
            ),
          ),
        ),
        Divider(),
        Container(
          height: 75,
          child: ElevatedButton(
            onPressed: () => cleanGame(),
            child: const Text(
              "Clean",
              textScaleFactor: 2,
            ),
          ),
        ),
      ],
    );
  }

  cleanGame() {
    setState(() {
      values = {
        0: 0,
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
        7: 0,
        8: 0,
      };
      scoreX = 0;
      scoreO = 0;
      turnPlayer = true;
    });
  }

  bool parMatch() {
    bool par = true;
    values.forEach((key, value) {
      if (value == 0) par = false;
    });
    return par;
  }
}
