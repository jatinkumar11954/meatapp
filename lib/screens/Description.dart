import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';

class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    final i = ModalRoute.of(context).settings.arguments;
    Short().init(context);
    final appbar = AppBar(
      backgroundColor: Colors.green,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context))
      ],
      // Color.fromRGBO(191, 32, 37, 1.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(Short.catgry[i]),
          // Image.asset(
          //   'images/logo.png',
          //   fit: BoxFit.fill,
          //   height: Short.h * 4.5,
          // ),
        ],
      ),
    );
    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;

    return Scaffold(
        appBar: appbar,
        drawer: Draw(context),
        body: WillPopScope(
            onWillPop: () {
              // Navigator.pushNamed(context,''),
              Navigator.pop(context);
            },
            child: ListView(
              children: <Widget>[
                Hero(
                  tag: i,
                  child: Image.network(
                    Short.img[i],
                    width: w,
                    height: h * 0.44,
                  ),
                ),
                ListTile(
                  title: Text(Short.catgry[i]),
                  subtitle: Text("29-30 Pieces"),
                ),
                Divider(thickness: 20),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Text("Weight: 400-500")),
                Row(
                  children: <Widget>[
                    Text("339",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: h * 0.025,
                          decoration: TextDecoration.lineThrough,
                        )),
                    Text("500",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: h * 0.025,
                        )),
                  ],
                )
              ],
            )));
  }
}
