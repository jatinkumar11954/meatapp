import 'package:flutter/cupertino.dart';

class Bottom with ChangeNotifier {
  int _index,_Tabindex;
  int get index => _index;
    int get tabIndex => _Tabindex;

  int get initial => 0;
  void updateINdex(int i) {
    print("this is inside udate" + i.toString());
    _index = i;
    notifyListeners();
  }
  void updateTab(int index){
     print("this is inside udate" + index.toString());
    _Tabindex = index;
    notifyListeners();
  }
}
