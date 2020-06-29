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

  void addToWatched(CartItem CartItem) async {
    await _repository.createUpdate(CartItem.id, CartItem.toMap());
  }

  Future<List<CartItem>> watchedCartItems(String query) async {
    final objects = query?.isNotEmpty == true
        ? await _repository.findObjects(query)
        : await _repository.getUniqueObjects();
    return objects.map((map) => CartItem().fromMap(map)).toList();
  }

  void removeFromWatched(CartItem CartItem) async {
    await _repository.removeObject(CartItem.id);
  }
}
