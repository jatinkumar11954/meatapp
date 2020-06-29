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
   this.id,
   this.img,
   this.title,
   this.catName,
   this.column,
   this.quantity,
   this.price,
    this.weight,
  });
  @override
  CartItem fromMap(Map map) {
    return CartItem(
      id: map[id],
      title: map[title],
      img: map[img],
      catName: map[catName],
      column: map[column],
      quantity: map[quantity],
      price: map[price],
      weight: map[weight],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      " title": title,
      "img": img,
      "catName": catName,
      "column": column,
      "quantity": quantity,
      "price": price,
      "weight": weight
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
