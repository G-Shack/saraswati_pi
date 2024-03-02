import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saraswati_pi/pages/start_page.dart';
import 'package:saraswati_pi/provider/table_values_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TableValuesProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: const ColorScheme.dark(
                background: Color(0xFF090d23),
                primary: Colors.pinkAccent,
                surface: Color(0xFF090d23))),
        home: const StartPage(),
      ),
    );
  }
}
