import 'package:flutter/material.dart';
import 'package:notes_app/Controller/add_notes_provider.dart';
import 'package:notes_app/Controller/delete_notes_provider.dart';
import 'package:notes_app/Controller/display_notes_provider.dart';
import 'package:notes_app/Controller/update_notes_provider.dart';
import 'package:notes_app/View/notes_display.dart';
import 'package:notes_app/View/splash_screen.dart';
import 'package:provider/provider.dart';

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
          ChangeNotifierProvider<NotesProvider>(create: (_) => NotesProvider()),
          ChangeNotifierProvider<DisplayNotesProvider>(create: (_) => DisplayNotesProvider()),
          ChangeNotifierProvider<DeleteNotesProvider>(create: (_) => DeleteNotesProvider()),
          ChangeNotifierProvider<UpdateNotesProvider>(create: (_) => UpdateNotesProvider()),

        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: ThemeData.dark(
            useMaterial3: true
        ),
        home: const SplashScreen(),
      ),
    );

  }
}

