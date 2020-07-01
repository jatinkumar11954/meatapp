import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:meatapp/Api/categoryApi.dart';
import 'package:meatapp/adjust/shimmer.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/main.dart';
import 'package:shimmer/shimmer.dart';

Widget Draw(BuildContext context) {
  return Drawer(
    child: SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // DrawerHeader(
          //   padding: EdgeInsets.fromLTRB(0, 0,0,0,),
          //   margin: EdgeInsets.all(0),
          //   child: Text('Login'),
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).primaryColor,
          //   ),
          // ),
          Container(
            color: Theme.of(context).primaryColor,
            child: ListTile(
              leading: new Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              trailing: new IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(isLogin ? 'Login' : "Profile",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          ListTile(
            leading: new Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Home', style: TextStyle(color: Colors.grey)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: new Icon(
              Icons.location_on,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Store Locator', style: TextStyle(color: Colors.grey)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: new Icon(
              Icons.phone_in_talk,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Contact Us', style: TextStyle(color: Colors.grey)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: new Icon(
              Icons.info,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Why FreshMeat?', style: TextStyle(color: Colors.grey)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    ),
  );
}

Widget Carousel(BuildContext context, GlobalKey<ScaffoldState> scaffoldkey) {
  return FutureBuilder<List<Scroll>>(
      future: getCarousel(scaffoldkey),
      builder: (context, carousel) {
        if (carousel.hasData) {
          return CarouselSlider(
            enlargeCenterPage: true,
            autoPlay: true,
            pauseAutoPlayOnTouch: Duration(seconds: 5),
            height: MediaQuery.of(context).size.height / 4,
            items: carousel.data.map((i) {

              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: GestureDetector(
                          child: CachedNetworkImage(
                            imageUrl: 
                            "http://via.placeholder.com/350x200",//testing
                            // i.img,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[400],
                                highlightColor: Colors.white,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      MediaQuery.of(context).size.width * 0.7,
                                  color: Colors.grey,
                                )),
                          ),
                          onTap: () {
                            // callSnackBar("clicked"+ i+"image",2);
                          }));
                },
              );
            }).toList(),
          );
        } else if (carousel.hasError) {
          return Text("${carousel.error}");
        }
        return Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.white,
            child: Shimmer.fromColors(
                baseColor: Colors.grey[400],
                highlightColor: Colors.white,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.width * 0.5,
                    color: Colors.grey,
                  ),
                )));
      });
}

Widget LoginBftrAnim(BuildContext context, Function loginFalse, UniqueKey k1) {
  return Container(
    key: k1,
    height: Short.h * 0.75,
    margin: EdgeInsets.only(top: Short.h * 0.16),
    width: Short.w,
    child: Padding(
        padding: EdgeInsets.only(
            bottom: Short.h * 0.14,
            top: Short.h * 0.15,
            left: Short.w * 0.03,
            right: Short.w * 0.03),
        child: Card(
          elevation: 15.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  bottom: Short.h * 0.015,
                  top: Short.h * 0.05,
                ),
                child: Center(
                    child: FlatButton(
                  onPressed: loginFalse,
                  child: Text(
                    "Login via Email / Phone",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Short.h * 0.025),
                  ),
                )),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Expanded(
                    //   child: new Container(
                    //       margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    //       child: Divider(
                    //         color: Colors.grey,
                    //         height: 36,
                    //       )),
                    // ),
                    Material(
                        color: Colors.white,
                        child: Text(
                          "or",
                          style: TextStyle(color: Colors.grey, fontSize: 19),
                        )),
                    // Expanded(
                    //   child: new Container(
                    //       margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    //       child: Divider(
                    //         color: Colors.grey,
                    //         height: 36,
                    //       )),
                    // ),
                  ]),
              Center(
                  child: Padding(
                padding: EdgeInsets.only(
                    top: Short.h * 0.015, bottom: Short.h * 0.025),
                child: FlatButton(
                  onPressed: () {
                    print("Login via otp");
                    Navigator.pushReplacementNamed(context, "LoginOtp");
                  },
                  child: Text(
                    "Login via OTP",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Short.h * 0.025),
                  ),
                ),
              )),
              Padding(
                padding: EdgeInsets.only(
                    top: Short.h * 0.02, bottom: Short.h * 0.03),
                child: Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Divider(
                        color: Colors.grey[300],
                        thickness: 2,
                        height: Short.h * 0.005)),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                        color: Colors.white,
                        child: Text(
                          "Don't have an account ? ",
                          style: TextStyle(color: Colors.grey, fontSize: 19),
                        )),
                    FlatButton(
                      onPressed: () => Navigator.pushNamed(context, 'SignUp'),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: Short.h * 0.021),
                      ),
                    ),
                  ]),
            ],
          ),
        )),
  );
}
