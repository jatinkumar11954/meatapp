import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:meatapp/Api/categoryApi.dart';

class SubCategory with ChangeNotifier {
  String catname, pieces;
  int id;
  int price,weight;
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
  
  void removeFrmCart(String r, int c) {
    int ro = catList.indexWhere((ele) {
      return ele.categoryName == r;
    });
    _items[ro][c].quantity=0;


    notifyListeners();
  }

  void toggleFavoriteStatus(String r, int c) {
    int ro = catList.indexWhere((ele) {
      return ele.categoryName == r;
    });
    _items[ro][c].fav = !_items[ro][c].fav;

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
