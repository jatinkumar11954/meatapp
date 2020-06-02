import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/adjust/short.dart';


Widget bottomBar(BuildContext context, int index) {
  return BottomNavigationBar(
    backgroundColor:
    // Colors.cyan[200],
     Colors.white70,
    elevation: 3,
    onTap: (index) {
      switch (index) {
        case 0:
          {
            Navigator.pushReplacementNamed(context, 'Main');
            break;
          }
        case 1:
          {
            Navigator.pushNamed(context, 'Desc');
            break;
          }

        case 2:
          {
            Navigator.pushNamed(context, 'up');
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
        icon: Icon(
          Icons.home,
          color: Colors.black54,
        ),
        title: Text('Home',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800)),
        activeIcon: Icon(
          Icons.home,
          color: Colors.green,
        ),
      ),
      BottomNavigationBarItem(
      
          icon: Icon(
            Icons.contacts,
             color:Colors.black54,
          ),
           activeIcon:Icon(
            Icons.contacts,
            color: Colors.green,
            //  color:Colors.black45,
          ),
          title: Text('Orders',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800)
          )),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            color: Colors.black87,
          ),
           activeIcon:Icon(
           Icons.account_circle,
            color: Colors.green,
            //  color:Colors.black45,
          ),
          title: Text('My Account',
            style: TextStyle(
                fontSize:20,
                fontWeight: FontWeight.w800))),
    ],
    // unselectedLabelStyle: TextStyle(color: Colors.white),
    selectedItemColor:  Colors.green,
    // fixedColor: 
    // Colors.grey,
    // Color.fromRGBO(127, 68, 0, .9),
  );
}
