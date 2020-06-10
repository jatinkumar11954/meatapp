import 'package:flutter/material.dart';

Widget ShrimGrid(BuildContext context, double h, double w) {
 return Padding(
          padding: EdgeInsets.only(left: w * 0.015, right: w * 0.015),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  // color: Colors.grey[300],
                  height: h * 0.20,
                  width: w * 0.45,
                  child:  Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        elevation: 4.0,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),))
                ),
                Center(
                    child:
                        Text("category", style: TextStyle(fontSize: h * 0.025)))
              ],
            ),
          ),
        );
}
