import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/db/SqlitePersistence.dart';
import 'package:meatapp/db/Storage.dart';
import 'package:meatapp/model/cart.dart';
import 'package:meatapp/model/subCategory.dart';

import 'package:flutter/material.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/screens/FirestScreen.dart';
import 'package:http/http.dart' as hp;
import 'package:provider/provider.dart';

hp.Response response, subResponse, scrollResponse;
const headers = {'Content-Type': 'application/json'};
List<Category> catList;
List<SubCategory> subCatList;
List<Scroll> scrollList;
List<CartItem> _it;
List<Fav> _fav;

Storage _repo;
Storage get repo => _repo;

List<List<SubCategory>> tab = List<List<SubCategory>>();
Future<List<Category>> getCategory(
    BuildContext context, dynamic category, dynamic cart) async {
  try {
    category.startLoading();
    _repo = await Storage.createFrom(
      future: SqlitePersistence.create(),
    );
    print("after create form" + _repo.toString());
    _it = await _repo.retriveCart();
    _fav = await _repo.retrieveFav();
    print("this is fav id");
    // print(_fav[1].id.toString());

    cart.setData(_it);

    response = await hp.get("${Short.baseUrl}/getcategory", headers: headers);
    subResponse =
        await hp.get("${Short.baseUrl}/getsubcategory", headers: headers);

    if (response != null) {
      Map catJson = json.decode(response.body);
      Map subCatJson = json.decode(subResponse.body);
      if (response.statusCode == 200) {
        // print("inside response status");
        catList = (catJson['data'] as List)
            .map((item) => new Category.fromJson(item))
            .toList();
        // print("this is category length ${catList.length}");
        for (int t = 0; t < catList.length; t++) print(catList[t].categoryName);
        subCatList = (subCatJson['data'] as List)
            .map((item) => new SubCategory.fromJson(item))
            .toList();
        // print("this is category length ${subCatList.length}");
        for (int t = 0; t < subCatList.length; t++) print(subCatList[t].item);
        subCatList.sort(((a, b) => a.catname.compareTo(b.catname)));
        getSubCategory();
        print("get cat");

        print("catlist ");
        print(catList.toString());
        category.setData(catList);

        category.endLoading();
        print("loading has end");
        return catList;
      }
      if (response.statusCode == 400) {
        category.endLoading();

        FlutterToast toast = FlutterToast(context);
        toast.showToast(
          child: Toastmsg(context, catJson["msg"].toString()),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );
        print("invalid username or password");
      }
    } //response is not null

  } on Exception catch (exception) {
    category.endLoading();

    FlutterToast toast = FlutterToast(context);
    toast.showToast(
      child: Toastmsg(context, "check your internet connnection $exception"),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  } catch (error) {
    category.endLoading();

    FlutterToast toast = FlutterToast(context);
    toast.showToast(
      child: Toastmsg(context, error.toString()),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}

getSubCategory() {
  bool whole = false;

  for (int i = 0; i < catList.length; i++) {
    for (int j = 0; j < subCatList.length; j++) {
      // print("this is j  $j");

      if (catList[i].categoryName == subCatList[j].catname) {
        if (tab.length == 0) {
          // print("one sub added into tab");
          tab.add([subCatList[j]]);
        } else if (tab.length <= catList.length) {
          // print("into tab length else if");
          for (int k = 0; k < tab.length && tab.length < catList.length; k++) {
            if (tab[k][0].catname != subCatList[j].catname) {
              whole = true;
            } else {
              whole = false;
            }
          }
          if (whole && tab.length < catList.length) {
            tab.add([subCatList[j]]);
          }
        }
        // print("this in the else if of adding subcatergory");
      }
    }
  }

  // for (int i = 0; i < tab.length; i++) {
  //   for (int j = 0; j < tab[i].length; j++) {
  //     print("${tab.length} $i $j");
  //     print(tab[i][j].catname);
  //   }
  // }
  // subCatList.sort(((a, b) => a.catname.compareTo(b.catname)));

  //  for (int j = 0; j < subCatList.length; j++) {
  //    print(subCatList[j].item );
  //  }
  int inc;
  print(tab.length);
  for (int i = 0; i < catList.length; i++) {
    // print("inside  for i ");

    for (int j = 0; j < subCatList.length; j++) {
      // print("inside  for j ");

      if (tab[i][0].catname == subCatList[j].catname) {
        for (int l = 0; l < tab[i].length; l++) {
          if (tab[i][l].id == subCatList[j].id) {
            // print("$l value inc");

            inc = l;
          }
        }
        if (tab[i][inc].id != subCatList[j].id) {
          // print("inside  for inc ");

          tab[i].insert(inc + 1, subCatList[j]);
        }
      }
    }
  }
  _fav != null
      ? _fav.forEach((favEle) {
          tab[favEle.row][favEle.col].fav = true;
        })
      : print("fav is empty");
  _it != null
      ? _it.forEach((element) {
          int ro = catList.indexWhere((ele) {
            return ele.categoryName == element.catName;
          });

          tab[ro][element.column].quantity = element.quantity;
        })
      : print("after tab has added");

  // for (int i = 0; i < tab.length; i++) {
  //   for (int j = 0; j < tab[i].length; j++) {
  //     print("${tab.length} $i $j");
  //     print(tab[i][j].catname);
  //   }
  // }
  return tab;
}

class Category with ChangeNotifier {
  String categoryName;
  int id;

  String img, desc;
  Category({
    this.categoryName,
    this.id,
    this.img,
    this.desc,
  });
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  startLoading() {
    _isLoading = true;
    // notifyListeners();
  }

  endLoading() {
    _isLoading = false;
    // notifyListeners();
  }

  List<Category> _categoryList = [];
  List<Category> get categoryList => _categoryList;
  factory Category.fromJson(Map<dynamic, dynamic> json) {
    return Category(
        categoryName: json['categoryname'],
        id: json["category_id"],
        img: json["img_url"]);
  }

  setData(List<Category> list) {
    list == null ? _categoryList = [] : _categoryList = list;
    notifyListeners();
  }
}

void getCarousel(BuildContext context) async {
  final scroll = Provider.of<Scroll>(context, listen: false);
  try {
    scroll.startLoading();
    scrollResponse =
        await hp.get("${Short.baseUrl}/getscrollimages", headers: headers);

    if (scrollResponse != null) {
      Map scrollJson = json.decode(scrollResponse.body);
      if (scrollResponse.statusCode == 200) {
        print("inside response status");
        scrollList = (scrollJson['data'] as List)
            .map((item) => new Scroll.fromJson(item))
            .toList();
        scroll.setScrollData(scrollList);
        scroll.endLoading();
      }
      if (scrollResponse.statusCode == 400) {
        scroll.endLoading();
        FlutterToast toast = FlutterToast(context);
        toast.showToast(
          child: Toastmsg(context, scrollJson["msg"]),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );
        print("carousel api bad req");
      }
    } //response is not null

  } on Exception catch (exception) {
    scroll.endLoading();
    FlutterToast toast = FlutterToast(context);
    toast.showToast(
      child: Toastmsg(
          context, "Check your Internet Connection" + exception.toString()),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  } catch (error) {
    scroll.endLoading();
    FlutterToast toast = FlutterToast(context);
    toast.showToast(
      child: Toastmsg(context, "error ${error.toString()}"),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}

class Scroll extends ChangeNotifier {
  int id;
  String img;
  List<Scroll> _scroll = [];
  bool _isScrollLoad = false;
  bool get isScrollLoad => _isScrollLoad;

  startLoading() {
    _isScrollLoad = true;
    // notifyListeners();
  }

  endLoading() {
    _isScrollLoad = false;
    // notifyListeners();
  }

  List<Scroll> get scrollList => _scroll;
  setScrollData(List<Scroll> scroll) {
    scroll == null ? _scroll = [] : _scroll = scroll;
    notifyListeners();
  }

  Scroll({this.id, this.img});
  factory Scroll.fromJson(Map<dynamic, dynamic> json) {
    return Scroll(id: json["image_id"], img: json["img_url"]);
  }
}
