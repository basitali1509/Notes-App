import 'package:flutter/foundation.dart';

class DisplayNotesProvider with ChangeNotifier {
  String _filter = 'all';

  get filter => _filter;

  void addFilter(String val) {
    _filter = val;
    notifyListeners();
  }
}
