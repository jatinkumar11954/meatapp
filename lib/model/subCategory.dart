import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:meatapp/Api/categoryApi.dart';

abstract class MapConvertible {
  Map<dynamic, dynamic> toMap();

  MapConvertible fromMap(Map<dynamic, dynamic> map);
}

class Fav extends MapConvertible {
  int id, col, row;

  Fav({this.col, this.id, this.row});

  @override
  Fav fromMap(Map<dynamic, dynamic> map) {
    return Fav(
      id: map["id"],
      row: map["row"],
      col: map["col"],
    );
  }

  @override
  Map<String, int> toMap() {
    return {
      "id": id,
      "col": col,
      "row": row,
    };
  }
}

class SubCategory extends ChangeNotifier {
  String catname;
  int id, pieces;
  int price, weight;
  int quantity;
  bool fav;
  String item, desc, img;
  SubCategory({
    this.catname,
    this.pieces,
    this.img,
    this.id,
    this.item,
    this.price,
    this.desc,
    this.weight,
    this.quantity = 0,
    this.fav = false,
  });
  factory SubCategory.fromJson(Map<dynamic, dynamic> json) {
    return SubCategory(
      catname: json['categoryname'],
      id: json["subcategory_id"],
      price: json["price"],
      item: json["itemname"],
      desc: json["description"],
      pieces: json["pieces"],
      weight: json["weight"],
      img: json["img_url"],
    );
  }
}

class Products with ChangeNotifier {
  List<List<SubCategory>> _items = tab;

  // var _showFavoritesOnly = false;

  List<List<SubCategory>> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.fav).toList();
    // }
    return [..._items];
  }

  List<SubCategory> get favoriteItems {
    List<SubCategory> pro;
    for (int i = 0; i < _items.length; i++) pro.addAll(_items[i]);
    return pro.where((prodItem) {
      return prodItem.fav;
    });
  }

  void addQuant(String r, int c) {
    int ro = catList.indexWhere((ele) {
      return ele.categoryName == r;
    });

    _items[ro][c].quantity += 1;
    notifyListeners();
  }

  void subQuant(String r, int c) {
    int ro = catList.indexWhere((ele) {
      return ele.categoryName == r;
    });
    _items[ro][c].quantity -= 1;

    notifyListeners();
  }

  void removeAll() {
    _items.forEach((column) {
      column.forEach((e) {
        e.quantity = 0;
      });
    });
    notifyListeners();
  }

  void removeFrmCart(String r, int c) {
    int ro = catList.indexWhere((ele) {
      return ele.categoryName == r;
    });
    _items[ro][c].quantity = 0;

    notifyListeners();
  }

  void toggleFavoriteStatus(String r, int c) {
    int ro = catList.indexWhere((ele) {
      return ele.categoryName == r;
    });
    _items[ro][c].fav = !_items[ro][c].fav;
    if (_items[ro][c].fav) {
      repo.addToFav(Fav(col: c, row: ro, id: _items[ro][c].id));
    } else {
      print("made false");
      repo.deleteFromFav( _items[ro][c].id);
    }
    notifyListeners();
  }
  // SubCategory findById(int id) {
  //   return _items[4].firstWhere((prod) => prod.id == id);
  // }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

}
