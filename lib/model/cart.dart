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
  @override
  CartItem fromMap(Map map) {
    return CartItem(
        id: 1,
        img: "img",
        title: "title",
        quantity: 1,
        catName: "catName",
        weight: 1,
        column: 1);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': 1,
      'imdbId': "imdbId",
      'name': "name",
      'imageUrl': "Url",
      'year': "year",
    };
  }
}

class Cart with ChangeNotifier {
  List<CartItem> _items = [];
  Map<String, CartItem> string;

  List<CartItem> get items {
    return [..._items];
  }

  int get itemCount {
    // print("this is item length ${_items.length}");
    //     print("this is item length ${_items.length}");

    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(int id, int price, int quan, String title, String img,
      String catName, int weight, int column) async {
    if (_items.contains(id.toString())) {
      // change quantity...
      print("into update cart");

      _items.replaceRange(_items.indexOf(_items.firstWhere((e) => e.id == id)),
          _items.indexOf(_items.firstWhere((e) => e.id == id)), [
        CartItem(
            id: id,
            img: img,
            title: title,
            price: price,
            quantity: quan + 1,
            catName: catName,
            weight: weight,
            column: column)
      ]);
    } else {
      print("into add cart");

      _items.add(
        CartItem(
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

  void reduceQuant(int id, int price, int quan, String title, String img,
      String catName, int weight, int column) {
    if (_items.contains(id.toString())) {
      // change quantity...
      print("into update cart");
      _items.replaceRange(_items.indexOf(_items.firstWhere((e) => e.id == id)),
          _items.indexOf(_items.firstWhere((e) => e.id == id)), [
        CartItem(
            id: id,
            img: img,
            title: title,
            price: price,
            quantity: quan - 1,
            catName: catName,
            weight: weight,
            column: column)
      ]);
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId.toString());
    notifyListeners();
  }

  void clear() {
    _items = [];
    notifyListeners();
  }
}
