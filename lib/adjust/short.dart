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
    static var chicken = {
    0: "ChickenCurryLeg",
    1: "ChickenCurry",
    2: "ChickenLeg",
    3: "Chicken65",
  };
     static var mutton = {
    0: " MuttonCurryLeg",
    1: " MuttonCurry",
    2: " MuttonLeg",
    3: " Mutton65",
  };
     static var egg = {
    0: " EggCurryLeg",
    1: " EggCurry",
    2: " EggLeg",
    3: " Egg65",
  };
     static var sea = {
    0: " SeaCurryLeg",
    1: " SeaCurry",
    2: " SeaLeg",
    3: " Sea65",
  };
  void init(BuildContext context) {
    h = (MediaQuery.of(context).size.height);
    w = (MediaQuery.of(context).size.width);
  }
}
