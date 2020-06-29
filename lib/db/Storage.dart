import 'package:meatapp/model/cart.dart';

import 'SqlitePersistence.dart';

class Storage {
  final SqlitePersistence _repository;

  static Future<Storage> createFrom({Future<SqlitePersistence> future}) async {
    final repository = await future;
    final ret = Storage(repository);

    return ret;
  }

  Storage(this._repository);

  void addToWatched(CartItem Item) async {
    await _repository.createUpdate( Item.toMap());
  }

  Future<List<CartItem>> watchedCartItems(String query) async {
    final objects =  await _repository.getCartfromDB() ;
    return objects.map((map) => CartItem().fromMap(map)).toList();
  }

  void removeFromWatched(CartItem Item) async {
    await _repository.removeObject(Item.id);
  }
}
