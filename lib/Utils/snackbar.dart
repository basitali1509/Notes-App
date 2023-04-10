
import 'package:flutter/material.dart';

class snackBar{
  static void showSnackBar(BuildContext context , String title){

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),

        duration: const Duration(seconds: 2),
        backgroundColor: Colors.redAccent,

        content: Text(title, style: const TextStyle(fontSize: 20, color: Colors.black87),),
      ),
    );

  }
}