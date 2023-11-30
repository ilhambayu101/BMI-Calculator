
import 'package:flutter/material.dart';
import 'package:serasisehat/view/FirstPage.dart';

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
      title: 'Aplikasi SerasiSehat',
      theme: ThemeData (
          scaffoldBackgroundColor: Color(0xFF16172E),
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 24
          ),
          textTheme: TextTheme(
            //for tittle
            titleLarge: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            //for subtittle
            labelLarge: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 0.1
            ),
            //for value headline
            headlineLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            // for date
            bodySmall: TextStyle(
                fontSize: 10,
                color: Color(0xFF858D9C)
            ),
          ),
          cardColor: Color(0xFF202137),
          cardTheme: CardTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))
      ),
      home: FirstPage(),
    );
  }
}



