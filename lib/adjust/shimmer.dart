import 'package:flutter/material.dart';

Widget ShrimGrid(BuildContext context, double h, double w) {
  SliverGrid(
    delegate: SliverChildBuilderDelegate(
      (BuildContext ctx, int i) {
        return Padding(
          padding: EdgeInsets.only(left: w * 0.015, right: w * 0.015),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: h * 0.20,
                  width: w * 0.45,
                ),
                Center(
                    child:
                        Text("category", style: TextStyle(fontSize: h * 0.025)))
              ],
            ),
          ),
        );
      },
      childCount: 4,
    ),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 98 / 90,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
    ),
  );
}
