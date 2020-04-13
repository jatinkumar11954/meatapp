import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Short{
 static double h,w;
 void init(BuildContext context) { 
    h= (MediaQuery.of(context).size.height);
       w= (MediaQuery.of(context).size.width);

   }
}
