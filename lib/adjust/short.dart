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
