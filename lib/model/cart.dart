import 'package:flutter/foundation.dart';
import 'package:meatapp/Api/categoryApi.dart';

abstract class MapConvertible {
  Map<dynamic, dynamic> toMap();
  Map<dynamic, dynamic> toOrder();

  MapConvertible fromMap(Map<dynamic, dynamic> map);
}

class CartItem extends MapConvertible {
  final int id;

  final String title;
  final String img;

  final String catName;
  final int column;
  int quantity;
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
  CartItem fromMap(Map<dynamic, dynamic> map) {
    return CartItem(
      id: map["id"],
      title: map["title"],
      img: map["img"],
      catName: map["catName"],
      column: map["column"],
      quantity: map["quantity"],
      price: map["price"],
      weight: map["weight"],
    );
  }

  // @override
  // Map<String, dynamic> toMap(CartItem obj) {
  //   print("inside toMap of cart ITem class "+obj.title);
  //   return {
  //     "id": obj.id,
  //     "title": obj.title,
  //     "img": obj.img,
  //     "catName": obj.catName,
  //     "column": obj.column,
  //     "quantity": obj.quantity,
  //     "price": obj.price,
  //     "weight": obj.weight
  //   };
  // }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "img": img,
      "catName": catName,
      "column": column,
      "quantity": quantity,
      "price": price,
      "weight": weight
    };
  }

  @override
  Map<String, dynamic> toOrder() {
    return {
      // "id": id,
      "title": title,
      "categoryname": catName,
      // "column": column,
      "quantity": quantity,
      "price": price,
      // "weight": weight
    };
  }
}

class Cart with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items {
    return [..._items];
  }

  bool get isLoading => _isLoading;
  bool _isLoading = false;
  startLoading() {
    _isLoading = true;
  }

  endLoading() {
    _isLoading = false;
  }

  setData(List<CartItem> i) {
    print("inside set data of cart");
    i == null ? _items = [] : _items.addAll(i);
    notifyListeners();
  }

  int get itemCount {
    if (_items == null) return 0;

    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    if (_items == null) return total;

    _items.forEach((cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void refresh() {
    notifyListeners();
  }

  bool isItem(CartItem _item) {
    bool _bool = false;
    if (_items.isNotEmpty) {
      _items.forEach((e) {
        if (e.title == _item.title)
          _bool = true;
        else
          _bool = false;
      });
      return _bool;
    }
  }

  int indexOF(CartItem _item) {
    if (_items.isNotEmpty) {
      int ind = _items.indexWhere((e) {
        return e.title == _item.title;
      });

      if (ind != -1) return ind;
    }
  }

  void addItem(CartItem item) async {
    if (_items.isNotEmpty) {
      if (isItem(item)) {
        print("increasing the quantity cart");

        _items[indexOF(item)].quantity = item.quantity + 1;

        repo.addToCart(_items[_items.indexWhere((e) {
          return e.title == item.title;
        })]);
      } else {
        print("else if item is not prest in else");
        bool _checkAdd = false;

        _items.forEach((e) {
          if (e.title == item.title) {
            _checkAdd = true;
          }
        });
        if (_checkAdd) {
          print("updating the db and quant incng");
          _items[indexOF(item)].quantity = item.quantity + 1;
          repo.updateCart(item);
        } else {
          _items.add(item);
          repo.addToCart(_items[_items.indexWhere((e) {
            return e.title == item.title;
          })]);
        }
      }
    } else {
      print("into add cart if null");

      _items.add(item);
      repo.addToCart(_items[_items?.indexOf(item)]);
    }
    notifyListeners();
  }

  void reduceQuant(CartItem item) {
    bool _checkSub = false;
    if (_items.isNotEmpty) {
      print(_items[_items.indexWhere((element) => element.id == item.id)]
          .quantity);

      if (_items[indexOF(item)].quantity == 1) {
        print("check sub is true");
        _checkSub = true;
      }
      print("this is the quantuty");
      print(_items[_items.indexWhere((element) => element.id == item.id)]
          .quantity);
      repo.addToCart(
          items[_items?.indexWhere((element) => element.id == item.id)]);

      _checkSub
          ? removeItem(item)
          : _items[_items.indexWhere((element) => element.id == item.id)]
              .quantity = item.quantity - 1;
    }

    notifyListeners();
  }

  void removeItem(CartItem item) {
    repo.deleteFromCart(item);
    _items.remove(_items[indexOF(item)]);

    notifyListeners();
  }

  void removeAll() async {
    await repo.removeAllfromTable();
    notifyListeners();
  }

  void clear() {
    _items = [];
    notifyListeners();
  }
}
