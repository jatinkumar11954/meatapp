import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/screens/FirestScreen.dart';
import 'package:meatapp/screens/profile/UserProfile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_route.dart';
import 'package:meatapp/main.dart';

Widget bottomBar(BuildContext context, int index) {
  return Theme(
     data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: Colors.white,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Colors.green,
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Colors.black))),
      child: BottomNavigationBar(
      
      // backgroundColor:
      // // Colors.cyan[200],
      //  Colors.white,
      // elevation: 3,
      onTap: (index) {
        switch (index) {
          case 0:
            {
                               Navigator.push(context, CustomRoute(builder: (context) => FirstScreen()));
              break;
            }
          case 1:
            {
              Navigator.pushNamed(context, 'Main');
              break;
            }

          case 2:
            {
                               Navigator.pushNamed(context, "MaterialPageRoute(builder: (context) => UserProfile())");
              break;
            }
        }
      },
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      items:
          //  <BottomNavigationBarItem>
          [
        BottomNavigationBarItem(
          
          icon: SvgPicture.asset("img/chicken.svg",      fit: BoxFit.contain,
          height: 40,
          // color:Colors.black,
          ),
          title: Center(
            child: Text('Home',
                style: TextStyle(
                  //  color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    )),
          ),
          // activeIcon:  SvgPicture.asset("img/chicken.svg",
          // fit: BoxFit.contain,
          // height: 40,
          // color: Colors.white,
          // )
        ),
        BottomNavigationBarItem(
        
            icon: Icon(
              Icons.contacts,
              //  color:Colors.black54,
            ),
            //  activeIcon:Icon(
            //   Icons.contacts,
            //   color: Theme.of(context).primaryColor,
            //   //  color:Colors.black45,
            // ),
            title: Text('Orders',
              style: TextStyle(
                  fontSize: 20,
                  )
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              // color: Colors.black87,
            ),
            //  activeIcon:Icon(
            //  Icons.account_circle,
            //   color: Theme.of(context).primaryColor,
            //   //  color:Colors.black45,
            // ),
            title: Text('My Account',
              style: TextStyle(
                  fontSize:20,
                  ))),
      ],
      // unselectedLabelStyle: TextStyle(color: Colors.white),
      // selectedItemColor:  Colors.white,
      // fixedColor: 
      // Colors.grey,
      // Color.fromRGBO(127, 68, 0, .9),
    ),
  );
}
