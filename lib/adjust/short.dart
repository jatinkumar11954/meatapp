import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Short {
  static double h, w;
  static var img = {
    0: "http://carigarifurniture.com/product_images/w/133365e0_a1b8_4f6d_89b5_d71cf79c27ef__92495_thumb.jpg",
    1: "http://carigarifurniture.com/product_images/h/img_6539__14221_thumb.jpg",
    2: "http://carigarifurniture.com/product_images/w/cbb92cd2_d785_4288_a51a_88766576d6aa_1___10086_thumb.jpg",
    3: "http://carigarifurniture.com/product_images/h/img_6539__14221_thumb.jpg",
  };
  static var catgry = {
    0: "CHICKEN",
    1: "MUTTON",
    2: "SEA FOOD",
    3: "EGGS",
  };
  void init(BuildContext context) {
    h = (MediaQuery.of(context).size.height);
    w = (MediaQuery.of(context).size.width);
  }
}
