import 'package:flutter/material.dart';
import 'package:saraswati_pi/pages/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.dark(
              background: Color(0xFF090d23),
              primary: Colors.pinkAccent,
              surface: Color(0xFF090d23))),
      home: const StartPage(),
    );
  }
}
