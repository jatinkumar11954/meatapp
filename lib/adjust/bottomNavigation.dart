import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/adjust/icons.dart';
import 'package:meatapp/model/bottom.dart';
import 'package:meatapp/screens/Description.dart';
import 'package:meatapp/screens/FirestScreen.dart';
import 'package:meatapp/screens/cart_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'custom_route.dart';
import 'package:meatapp/main.dart';

Widget bottomBar(BuildContext context, int i) {
  print(i.toString());
//   // Theme(
//   //    data: Theme.of(context).copyWith(
//   //       // sets the background color of the `BottomNavigationBar`
//   //       canvasColor: Colors.white,
//   //       // sets the active color of the `BottomNavigationBar` if `Brightness` is light
//   //       primaryColor: Colors.green,
//   //       textTheme: Theme
//   //           .of(context)
//   //           .textTheme
//   //           .copyWith(caption: new TextStyle(color: Colors.black))),
//       // child:
//        BottomNavigationBar(

//       // backgroundColor:
//       // // Colors.cyan[200],
//       //  Colors.white,
//       // elevation: 3,
//       onTap: (index) {
//         switch (index) {
//           case 0:
//             {
//                                Navigator.push(context, CustomRoute(builder: (context) => FirstScreen()));
//               break;
//             }
//           case 1:
//             {
//               Navigator.pushNamed(context, 'Main');
//               break;
//             }

//           case 2:
//             {
//                                Navigator.push(context, CustomRoute(builder: (context) => UserProfile()));
//               break;
//             }
//         }
//       },
//       type: BottomNavigationBarType.fixed,
//       currentIndex: index,
//       items:
//           //  <BottomNavigationBarItem>
//           [
//         BottomNavigationBarItem(

//           icon: SvgPicture.asset("img/chicken.svg",      fit: BoxFit.contain,
//           height: 40,
//           // color:Colors.black,
//           ),
//           title: Center(
//             child: Text('Home',
//                 style: TextStyle(
//                   //  color: Theme.of(context).primaryColor,
//                     fontSize: 20,
//                     )),
//           ),
//           // activeIcon:  SvgPicture.asset("img/chicken.svg",
//           // fit: BoxFit.contain,
//           // height: 40,
//           // color: Colors.white,
//           // )
//         ),
//         BottomNavigationBarItem(

//             icon: Icon(
//               Icons.contacts,
//               //  color:Colors.black54,
//             ),
//             //  activeIcon:Icon(
//             //   Icons.contacts,
//             //   color: Theme.of(context).primaryColor,
//             //   //  color:Colors.black45,
//             // ),
//             title: Text('Orders',
//               style: TextStyle(
//                   fontSize: 20,
//                   )
//             )),
//         BottomNavigationBarItem(
//             icon: Icon(
//               Icons.account_circle,
//               // color: Colors.black87,
//             ),
//             //  activeIcon:Icon(
//             //  Icons.account_circle,
//             //   color: Theme.of(context).primaryColor,
//             //   //  color:Colors.black45,
//             // ),
//             title: Text('My Account',
//               style: TextStyle(
//                   fontSize:20,
//                   ))),
//       ],
//       // unselectedLabelStyle: TextStyle(color: Colors.white),
//       // selectedItemColor:  Colors.white,
//       // fixedColor:
//       // Colors.grey,
//       // Color.fromRGBO(127, 68, 0, .9),
//     // ),
//   );
// }
  final _selectedItemColor = Colors.white;
  final _unselectedItemColor = Theme.of(context).primaryColor;
  final _selectedBgColor = Theme.of(context).primaryColor;
  final _unselectedBgColor = Colors.white;
    int _selectedIndex= Provider.of<Bottom>(context).index==null?0:Provider.of<Bottom>(context).index;

   


  Color _getBgColor(int index) =>
      _selectedIndex == index ? _selectedBgColor : _unselectedBgColor;

  Color _getItemColor(int index) =>
      _selectedIndex == index ? _selectedItemColor : _unselectedItemColor;
  Widget _buildIcon(BuildContext c, String data, String text, int inde) =>
      Consumer<Bottom>(
        builder: (context, value, child) {
          return Container(
            width: double.infinity,
            height: kBottomNavigationBarHeight,
            child: Material(
              color: _getBgColor(inde),
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                 SvgPicture.asset(data,
          // fit: BoxFit.contain,
          height: 30,
          color: _getItemColor(inde),
          ),
                    Text(text,
                        style: TextStyle(
                            fontSize: 12, color: _getItemColor(inde))),
                  ],
                ),
                onTap: () {
                  value.updateINdex(inde);
                  _selectedIndex = value.index;
 switch (_selectedIndex) {
          case 0:
            {
              print("index 0");
              Navigator.pushReplacement(
                  context, CustomRoute(builder: (context) => FirstScreen()));
              break;
            }
          case 1:
            {
              Navigator.pushReplacement(
                  c, CustomRoute(builder: (context) => CartScreen()));
              break;
            }

          case 2:
            {
              Navigator.pushReplacement(
                 c, CustomRoute(builder: (context) => Description()));
              break;
            }
        }
                },
              ),
            ),
          );
        },
      );
       Widget _buildSvg(BuildContext c, String data, String text, int inde) =>
      Consumer<Bottom>(
        builder: (context, value, child) {
          return Container(
            width: double.infinity,
            height: kBottomNavigationBarHeight,
            child: Material(
              color: _getBgColor(inde),
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Icon(
                  CustomIcon.info_circled,
                  size: 20,
          color: _getItemColor(inde),
          ),
                    Text(text,
                        style: TextStyle(
                            fontSize: 12, color: _getItemColor(inde))),
                  ],
                ),
                onTap: () {
                  value.updateINdex(inde);
                  _selectedIndex = value.index;
 switch (_selectedIndex) {
          case 0:
            {
              print("index 0");
              Navigator.pushReplacement(
                  context, CustomRoute(builder: (context) => FirstScreen()));
              break;
            }
          case 1:
            {
              Navigator.pushReplacement(
                  c, CustomRoute(builder: (context) => CartScreen()));
              break;
            }

          case 2:
            {
              Navigator.pushReplacement(
                 c, CustomRoute(builder: (context) => Description()));
              break;
            }
        }
                },
              ),
            ),
          );
        },
      );




  return  BottomNavigationBar(
      selectedFontSize: 0,
     
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _buildIcon(context, "img/chicken.svg", 'Home', 0),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: _buildSvg(context, "img/deals.svg", 'Business', 1),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(context, "img/icons2.svg", 'School', 2),
          title: SizedBox.shrink(),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: _selectedItemColor,
      unselectedItemColor: _unselectedItemColor,
   
  );
}
