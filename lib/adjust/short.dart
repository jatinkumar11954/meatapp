import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Short {
  static double h, w;
  static var baseUrl = "http://15.206.247.189:3000/user";
  // cd /var/www/html/apis/freshMeat-api
  static var img = {
    0: "http://carigarifurniture.com/product_images/w/133365e0_a1b8_4f6d_89b5_d71cf79c27ef__92495_thumb.jpg",
    1: "http://carigarifurniture.com/product_images/h/img_6539__14221_thumb.jpg",
    2: "http://carigarifurniture.com/product_images/w/cbb92cd2_d785_4288_a51a_88766576d6aa_1___10086_thumb.jpg",
    3: "http://carigarifurniture.com/product_images/h/img_6539__14221_thumb.jpg",
  };
  static var cat = {
    0: chicken,
    1: mutton,
    2: sea,
    3: egg,
    4: deal,
  };
  static var icon = {
    0: Icons.home,
    1: Icons.rss_feed,
    2: Icons.perm_identity,
    3: Icons.settings,
    // 4: Icons.linear_scale
  };

  static var catgry = {
    0: "CHICKEN",
    1: "MUTTON",
    2: "SEA FOOD",
    3: "EGGS",
    4: "DEALS",
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
  static var deal = {
    0: " SeaCurryLeg",
    1: " SeaCurry",
    2: " SeaLeg",
    3: " Sea65",
  };

  get s => catgry;
  void init(BuildContext context) {
    h = (MediaQuery.of(context).size.height);
    w = (MediaQuery.of(context).size.width);
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  String validateAddr(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  String validateMobile(String value) {
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validatePin(String value) {
    if (value.length <= 5)
      return 'Length must be greater than 5';
    else
      return null;
  }

  String validatePwd(String value) {
    if (value.length <= 6)
      return 'Length must be greater than 6';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}
