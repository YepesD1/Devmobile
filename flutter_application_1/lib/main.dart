import 'package:flutter/material.dart';
import 'package:flutter_application_1/homeScreen.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const new({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: HomeScreen(),
    );
  }
}
