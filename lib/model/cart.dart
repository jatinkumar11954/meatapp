import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final int id;

  final String title;
  final String img;

  final String catName;
  final int column;
  final int quantity;
  final int price;
  final int weight;

  CartItem({
    @required this.id,
    @required this.img,
    @required this.title,
    @required this.catName,
    @required this.column,
    @required this.quantity,
    @required this.price,
    this.weight,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String,CartItem> string;
  Map<String, List<String>> _itemlist = {};
  SharedPreferences s;
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    // print("this is item length ${_items.length}");
    //     print("this is item length ${_items.length}");

    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(int id, int price, String title, String img, String catName,
      int weight, int column) async {
    s = await SharedPreferences.getInstance();
    if (_items.containsKey(id.toString())) {
      // change quantity...
      print("into update cart");
      _items.update(
        id.toString(),
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            img: existingCartItem.img,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity + 1,
            catName: existingCartItem.catName,
            weight: existingCartItem.weight,
            column: existingCartItem.column),
      );
    
    } else {
      print("into add cart");

      _items.putIfAbsent(
        id.toString(),
        () => CartItem(
            id: id,
            img: img,
            title: title,
            price: price,
            quantity: 1,
            catName: catName,
            weight: weight,
            column: column),
      );
    }
    notifyListeners();
  }

  void reduceQuant(int id, int price, String title, String img, String catName,
      int weight, int column) {
    if (_items.containsKey(id.toString())) {
      // change quantity...
      print("into update cart");
      _items.update(
        id.toString(),
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            img: existingCartItem.img,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1,
            catName: existingCartItem.catName,
            weight: existingCartItem.weight,
            column: existingCartItem.column),
      );
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId.toString());
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
