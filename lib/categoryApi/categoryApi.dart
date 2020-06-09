import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/screens/FirestScreen.dart';
import 'package:http/http.dart' as hp;

hp.Response response, subResponse;
const headers = {'Content-Type': 'application/json'};
List<Category> catList;
List<SubCategory> subCatList;
List<List<SubCategory>> tab = List<List<SubCategory>>();
Future<List<Category>> getCategories(GlobalKey<ScaffoldState> scaffoldkey) async {
  try {
    response = await hp.get("${Short.baseUrl}/getcategory", headers: headers);
    subResponse =
        await hp.get("${Short.baseUrl}/getsubcategory", headers: headers);

    if (response != null) {
      Map catJson = json.decode(response.body);
      Map subCatJson = json.decode(response.body);
      if (response.statusCode == 200) {
        print("inside response status");
        catList = (catJson['data'] as List)
            .map((item) => new Category.fromJson(item))
            .toList();
        subCatList = (subCatJson['data'] as List)
            .map((item) => new SubCategory.fromJson(item))
            .toList();
        subCatList.sort(((a, b) => a.catname.compareTo(b.catname)));
        getSubCategory();
        return catList;
      }
      if (response.statusCode == 400) {
        callSnackBar("${catJson["msg"]}",scaffoldkey);

        print("invalid username or password");
      }
    } //response is not null

  } on Exception catch (exception) {
    callSnackBar("network problem",scaffoldkey);
  } catch (error) {
    callSnackBar(error.toString(),scaffoldkey);
  }
}

getSubCategory() {
  for (int i = 0; i < catList.length; i++) {
    for (int j = 0; j < subCatList.length; j++) {
      print("this is j  $j");

      if (catList[i].categoryName == subCatList[j].catname) {
        if (tab.length == 0) {
          tab.add([subCatList[j]]);
        } else if (tab.length <= catList.length) {
          for (int k = 0; k < tab.length && tab.length < catList.length; k++)
            if (tab[k][0].catname != subCatList[j].catname &&
                tab[k][0].id != subCatList[j].id) tab.add([subCatList[j]]);
        }
      }
    }
  }
  int inc;
  for (int i = 0; i < catList.length; i++) {
    for (int j = 0; j < subCatList.length; j++) {
      if (tab[i][0].catname == subCatList[j].catname) {
        for (int l = 0; l < tab[i].length; l++) {
          if (tab[i][l].id == subCatList[j].id) {
            inc = l;
          }
        }
        if (tab[i][inc].id != subCatList[j].id) {
          tab[i].insert(inc + 1, subCatList[j]);
        }
      }
    }
  }

  for (int i = 0; i < tab.length; i++) {
    for (int j = 0; j < tab[i].length; j++) {
      print("${tab.length} $i $j");
      print(tab[i][j].catname);
    }
  }
  return tab;

}

class SubCategory {
  String catname;
  int id, price;
  String item, desc;
  SubCategory({this.catname, this.id, this.item, this.price, this.desc});
  factory SubCategory.fromJson(Map<dynamic, dynamic> json) {
    return SubCategory(
        catname: json['categoryName'],
        id: json["SubCategoryegory_id"],
        price: json["price"],
        item: json["itemname"],
        desc: json["description"]);
  }
}

class Category {
  String categoryName;
  int id;
  String img, desc;
  Category({this.categoryName, this.id, this.img});
  factory Category.fromJson(Map<dynamic, dynamic> json) {
    return Category(
        categoryName: json['categoryName'],
        id: json["category_id"],
        img: json["img_url"]);
  }
}
