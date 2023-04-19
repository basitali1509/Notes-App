import 'package:flutter/foundation.dart';
import 'package:notes_app/Model/db_helper.dart';
import 'package:notes_app/Model/db_model.dart';

class UpdateNotesProvider with ChangeNotifier {
  int _priority = 1;
  int get priority => _priority;

  void setPriority(int priority) {
    _priority = priority;
    notifyListeners();
  }

  void updateNote(Notes note, DatabaseHelper databaseHelper) {
    databaseHelper.update(note);
    notifyListeners();
  }
}
