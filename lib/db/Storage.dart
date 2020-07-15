import 'package:meatapp/model/cart.dart';
import 'package:meatapp/model/subCategory.dart';

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
  void logout() {
    _repository.clearTable();
  }

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

  Future<void> deleteFromCart(CartItem Item) async {
    await _repository.deletefrmTable(Item.id);
  }


  void removeAllfromTable() async {
    await _repository.clearTable();
  }


  void addToFav(Fav Item) async {
    print(_repository.toString());

    print("inside addtocart  of repo " + Item.id.toString());
    await _repository.createFav(Item.toMap());
  }

  Future<List<Fav>> retrieveFav() async {
    final objects = await _repository.getFavfromDb();

    if (objects.length == 0) return null;
    // print("object retrieved " + objects[0]["title"]);
    return objects.map((map) => Fav().fromMap(map)).toList();
  }

  Future<void> deleteFromFav(int id) async {
    await _repository.deletefromFav(id);
  }
}
