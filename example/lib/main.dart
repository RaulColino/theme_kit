import 'package:flutter/material.dart';
import 'package:theme_kit/theme_kit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AtomizeText.displayXL("Display XL").styles(
            color: Colors.red,
            fontWeight: TKFontWeight.bold,
          ),
        ],
      ),
    );
  }
}
