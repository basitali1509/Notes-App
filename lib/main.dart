import 'package:flutter/material.dart';
import 'package:notes_app/View/notes_display.dart';
import 'package:notes_app/View/splash_screen.dart';

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
      title: 'Notes App',
      theme: ThemeData.dark(
        useMaterial3: true
      ),
      home: const SplashScreen(),
    );
  }
}

