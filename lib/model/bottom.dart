import 'package:flutter/cupertino.dart';

class Bottom with ChangeNotifier {
  int _index;
  int get index => _index;
  void updateINdex(int i) {
    _index = i;
    notifyListeners(); 
  }
}
