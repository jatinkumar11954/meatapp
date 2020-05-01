import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/screens/animate.dart';

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
class widget extends StatefulWidget {
  @override
  _widgetState createState() => _widgetState();
}

class _widgetState extends State<widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

Widget LoginBftrAnim(BuildContext context, Function loginFalse,UniqueKey k1) {
  return Container(
    key: k1,
    height: Short.h * 0.8,
    width: Short.w,
    child: Padding(
        padding: EdgeInsets.only(
            bottom: Short.h * 0.14,
            top: Short.h * 0.18,
            left: Short.w * 0.03,
            right: Short.w * 0.03),
        child: Card(
          elevation: 15.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: FlatButton(
                onPressed: loginFalse,
                child: Text(
                  "Login via Email / Phone",
                  style:
                      TextStyle(color: Colors.green, fontSize: Short.h * 0.025),
                ),
              )),
              Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color: Colors.grey,
                        height: 36,
                      )),
                ),
                Material(
                    color: Colors.white,
                    child: Text(
                      "or",
                      style: TextStyle(
                          color: Colors.grey, fontSize: Short.h * 0.02),
                    )),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(
                        color: Colors.grey,
                        height: 36,
                      )),
                ),
              ]),
              Center(
                  child: Padding(
                padding: EdgeInsets.only(
                    top: Short.h * 0.02, bottom: Short.h * 0.02),
                child: FlatButton(
                  onPressed: () {
                    print("Login via otp");
                  },
                  child: Text(
                    "Login via OTP",
                    style: TextStyle(
                        color: Colors.green, fontSize: Short.h * 0.025),
                  ),
                ),
              )),
              Padding(
                padding: EdgeInsets.only(
                    top: Short.h * 0.02, bottom: Short.h * 0.05),
                child:
                    Divider(color: Colors.grey[300], thickness: Short.h * 0.01),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                        color: Colors.white,
                        child: Text(
                          "Don't have an account ? ",
                          style: TextStyle(
                              color: Colors.grey, fontSize: Short.h * 0.025),
                        )),
                    FlatButton(
                      onPressed:() =>Navigator.pushNamed(context,'SignUp'),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.green, fontSize: Short.h * 0.025),
                      ),
                    ),
                  ]),
            ],
          ),
        )),
  );
}

// Widget SigUp(
//     BuildContext context, Function loginTrue, Function _toggle, UniqueKey k3,GlobalKey _form) {
//   TextEditingController email;
//   TextEditingController pwd;
//   bool showPwd = true;
//   Icon _icon = Icon(
//     Icons.visibility,
//   );

//   return Container(
//     key: k3,
//     height: Short.h * 0.82,
//     width: Short.w,

//     // Define how long the animation should take.

//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(80), topRight: Radius.circular(80))),
//     child: Column(
//       children: <Widget>[
//         Center(
//           child: Material(
//             color: Colors.white,
//             child: Text(
//               "SignUp",
//               style: TextStyle(color: Colors.green, fontSize: Short.h * 0.046),
//             ),
//           ),
//         ),
//         // SizedBox(height:Short.h*0.1),

//         Form(
//           key: _form,
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: 25, left: Short.w * 0.07, right: Short.w * 0.07),
//                 child: Material(
//                   color: Colors.white,
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       labelStyle: TextStyle(
//                           color: Colors.grey, fontSize: Short.h * 0.02),
//                       labelText: 'Email/Phone',
//                       hintText: "Enter your email /Phone",
//                       hintStyle: TextStyle(
//                           color: Colors.grey, fontSize: Short.h * 0.02),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(Short.h * 2.5)),
//                     ),
//                     controller: email,
//                     keyboardType: TextInputType.emailAddress,
//                     // validator: emailValidator,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: 25, left: Short.w * 0.07, right: Short.w * 0.07),
//                 child: Material(
//                   color: Colors.white,
//                   child: TextFormField(
//                     obscureText: showPwd,
//                     decoration: InputDecoration(
//                       labelStyle: TextStyle(
//                           color: Colors.grey, fontSize: Short.h * 0.02),
//                       labelText: 'Password',
//                       hintText: "Enter your Password",
//                       hintStyle: TextStyle(
//                           color: Colors.grey, fontSize: Short.h * 0.02),
//                       suffixIcon: IconButton(
//                         icon: _icon,
//                         onPressed: _toggle,
//                       ),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(Short.h * 2.5)),
//                     ),
//                     controller: pwd,
//                     keyboardType: TextInputType.visiblePassword,
//                     validator: pwdValidator,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Material(
//                   color: Colors.white,
//                   child: Text(
//                     "Don't have an account ? ",
//                     style: TextStyle(
//                         color: Colors.grey, fontSize: Short.h * 0.025),
//                   )),
//               FlatButton(
//                 onPressed: loginTrue,
//                 child: Text(
//                   "Sign Up",
//                   style:
//                       TextStyle(color: Colors.green, fontSize: Short.h * 0.025),
//                 ),
//               ),
//             ]),
//       ],
//     ),
//   );
// }
