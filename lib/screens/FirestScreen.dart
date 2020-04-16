import 'package:flutter/material.dart';

import '../short.dart';
class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {

     final appbar=AppBar(
          backgroundColor: Colors.green,
          // Color.fromRGBO(191, 32, 37, 1.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          
              
              // Image.asset(
              //   'images/logo.png',
              //   fit: BoxFit.fill,
              //   height: Short.h * 4.5,
              // ),
            ],
          ),
          leading: Icon(Icons.search),
        );

    return Scaffold(
      appBar: appbar,
      drawer: Container(),
      
    );
  }
}