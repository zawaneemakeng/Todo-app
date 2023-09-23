import 'package:flutter/material.dart';
import 'package:todolist/intro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Totolist',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff8369B4),
        ),
        useMaterial3: true,
        fontFamily: 'PK',
      ),
      home: const IntroPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
