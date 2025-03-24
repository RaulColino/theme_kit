import 'package:flutter/material.dart';
import 'package:theme_kit/theme_kit.dart';

sealed class AtomizeText extends TKText {
  AtomizeText(super.data, {super.key});

  ///Returns a Display XL text
  ///Display M text is used for large texts in large displays.
  static TKText displayXL(String data) => TKText(data).styles(
        fontSize: 48,
        fontWeight: TKFontWeight.bold,
        fontFamily: TKFontFamily.inter,
      );
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AtomizeText.displayXL("Display XL").styles(
              color: Colors.red,
              fontWeight: TKFontWeight.bold,
            ),
            AtomizeText.displayXL("Display XL 2").styles(
              fontFamily: TKFontFamily.inter,
            ),
          ],
        ),
      ),
    );
  }
}
