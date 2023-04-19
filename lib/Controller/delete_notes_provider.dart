import 'package:flutter/foundation.dart';
import 'package:notes_app/Model/db_helper.dart';
import 'package:notes_app/Model/db_model.dart';

class DeleteNotesProvider with ChangeNotifier {
  Future<void> deleteNotes(DatabaseHelper databaseHelper, int id) async {
    databaseHelper.delete(id);
    notifyListeners();
  }
}
