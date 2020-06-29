import 'package:flutter/cupertino.dart';

class Bottom with ChangeNotifier {
  int _index;
  int get index => _index;
  int get initial => 0;
  void updateINdex(int i) {
    print("this is inside udate" + i.toString());
    _index = i;
    notifyListeners();
  }
}
