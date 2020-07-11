import 'package:meatapp/model/cart.dart';

import 'SqlitePersistence.dart';

class Storage {
  final SqlitePersistence _repository;

  static Future<Storage> createFrom({Future<SqlitePersistence> future}) async {
    final repository = await future;
    print(repository.toString());
    final ret = Storage(repository);

    return ret;
  }

  Storage(this._repository);

  void addToCart(CartItem Item) async {
    print(_repository.toString());

    print("inside addtocart  of repo " + Item.title);
    await _repository.createUpdate(Item.toMap());
    
  }

  Future<List<CartItem>> retriveCart() async {
    final objects = await _repository.getCartfromDB();

    if (objects.length == 0) return null;
    print("object retrieved " + objects[0]["title"]);
    return objects.map((map) => CartItem().fromMap(map)).toList();
  }
  void deleteFromCart(CartItem Item)async{
        await _repository.deletefrmTable(Item.id);

  }
   void updateCart(CartItem Item)async{
        await _repository.updateTable(Item.quantity, Item.id);

  }

  void removeAllfromTable() async{
    await _repository.clearTable();
  }

  void removeFromWatched(int itemId) async {
    await _repository.removeObject(itemId);
  }
}
