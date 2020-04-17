import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

Widget Draw(BuildContext context) {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Drawer Header'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    ),
  );
}

Widget Carousel(BuildContext context) {
  return CarouselSlider(
    enlargeCenterPage: true,
    autoPlay: true,
    pauseAutoPlayOnTouch: Duration(seconds: 5),
    height: MediaQuery.of(context).size.height / 4,
    items: [
      "http://carigarifurniture.com/product_images/w/133365e0_a1b8_4f6d_89b5_d71cf79c27ef__92495_thumb.jpg",
      "http://carigarifurniture.com/product_images/h/img_6539__14221_thumb.jpg",
      "http://carigarifurniture.com/product_images/w/cbb92cd2_d785_4288_a51a_88766576d6aa_1___10086_thumb.jpg",
      "http://carigarifurniture.com/product_images/h/img_6539__14221_thumb.jpg",
      "http://carigarifurniture.com/product_images/w/cbb92cd2_d785_4288_a51a_88766576d6aa_1___10086_thumb.jpg"
    ].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              decoration:
                  BoxDecoration(color: Color.fromRGBO(255, 184, 102, .2)),
              child: GestureDetector(
                  child: Image.network(
                    i,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                            // value: loadingProgress.expectedTotalBytes != null
                            //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                            //     : null,
                            ),
                      );
                    },
                    height: MediaQuery.of(context).size.width,
                  ),
                  onTap: () {
                    // callSnackBar("clicked"+ i+"image",2);
                  }));
        },
      );
    }).toList(),
  );
}
