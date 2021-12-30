import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/screens/game.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          "assets/game-background.jpg",
        ),
        fit: BoxFit.cover,
      )),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("TIC TAC TOE GAME", textScaleFactor: 1.5),
            Divider(),
            Container(
              height: 75,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Game()),
                    (Route<dynamic> route) => false),
                child: Text("S T A R T G A M E", textScaleFactor: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
