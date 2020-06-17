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
                               Navigator.push(context, CustomRoute(builder: (context) => UserProfile()));
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
// final _selectedItemColor = Colors.white;
// final _unselectedItemColor = Colors.white30;
// final _selectedBgColor = Colors.indigo;
// final _unselectedBgColor = Colors.blue;
// int _selectedIndex = 0;
//  const TextStyle optionStyle =
//     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//  const List<Widget> _widgetOptions = <Widget>[
//   Text(
//     'Index 0: Home',
//     style: optionStyle,
//   ),
//   Text(
//     'Index 1: Business',
//     style: optionStyle,
//   ),
//   Text(
//     'Index 2: School',
//     style: optionStyle,
//   ),
// ];

// // void _onItemTapped(int index) {
// //   setState(() {
// //     _selectedIndex = index;
// //   });
// // }

// Color _getBgColor(int index) =>
//     _selectedIndex == index ? _selectedBgColor : _unselectedBgColor;

// Color _getItemColor(int index) =>
//     _selectedIndex == index ? _selectedItemColor : _unselectedItemColor;

// Widget _buildIcon(IconData iconData, String text, int index) => Container(
//       width: double.infinity,
//       height: kBottomNavigationBarHeight,
//       child: Material(
//         color: _getBgColor(index),
//         child: InkWell(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Icon(iconData),
//               Text(text,
//                   style: TextStyle(fontSize: 12, color: _getItemColor(index))),
//             ],
//           ),
//           onTap: () {},
//         ),
//       ),
//     );

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('BottomNavigationBar Sample'),
//     ),
//     body: Center(
//       child: _widgetOptions.elementAt(_selectedIndex),
//     ),
//     bottomNavigationBar: BottomNavigationBar(
//       selectedFontSize: 0,
//       items: <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: _buildIcon(Icons.home, 'Home', 0),
//           title: SizedBox.shrink(),
//         ),
//         BottomNavigationBarItem(
//           icon: _buildIcon(Icons.business, 'Business', 1),
//           title: SizedBox.shrink(),
//         ),
//         BottomNavigationBarItem(
//           icon: _buildIcon(Icons.school, 'School', 2),
//           title: SizedBox.shrink(),
//         ),
//       ],
//       currentIndex: _selectedIndex,
//       selectedItemColor: _selectedItemColor,
//       unselectedItemColor: _unselectedItemColor,
//     ),
//   );
// }