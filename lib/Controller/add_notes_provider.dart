import 'package:flutter/foundation.dart';
import 'package:notes_app/Model/db_helper.dart';
import 'package:notes_app/Model/db_model.dart';

class NotesProvider extends ChangeNotifier {
  int _priority = 1;
  int get priority => _priority;

  void setPriority(int priority) {
    _priority = priority;
    notifyListeners();
  }

  void addNote(Notes note, DatabaseHelper databaseHelper) {
    databaseHelper.insert(note);
    notifyListeners();
  }
}
