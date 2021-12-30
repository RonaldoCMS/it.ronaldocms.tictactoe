import 'package:flutter/material.dart';
import 'package:tictactoe/screens/game.dart';
import 'package:tictactoe/screens/homepage.dart';
import 'package:tictactoe/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeDefault(),
      home: const HomePage(),
    );
  }
}
