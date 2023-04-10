import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_app/View/notes_display.dart';

class SplashScreenController {
  void SplashTime(BuildContext context) {
      Timer(
          const Duration(milliseconds: 3000),
              () =>
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DisplayNotes())));
    }

}