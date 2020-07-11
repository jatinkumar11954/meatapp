import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meatapp/location/locator.dart';
import 'package:meatapp/screens/Description.dart';
import 'package:meatapp/screens/FirestScreen.dart';
import 'package:meatapp/screens/entry/Otp.dart';
import 'package:meatapp/screens/entry/Login.dart';
import 'package:meatapp/screens/entry/loginOtp.dart';
import 'package:meatapp/screens/profile/UserProfile.dart';
import 'package:meatapp/screens/profile/manageProfile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/bottom.dart';
import 'model/cart.dart';
import 'model/subCategory.dart';
import 'screens/entry/Signup.dart';
import 'screens/tabScreen.dart' as f;

String jwt;
bool login = false;
bool get isLogin => login;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  jwt = await prefs.getString("jwt");
 login=  jwt != null? true: false;
  var g = Geolocator()..forceAndroidLocationManager;
  g.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
// place();
  // SharedPreferences store = await SharedPreferences.getInstance();
  // store.("jwt");

  // print('jwt ${jwt}');
  runApp(MyApp());
}
// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Bottom(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: 'Sans',
                  ),
               
              // fontFamily: ,
              primaryColor: Color.fromRGBO(0, 175, 136, 1.0),
              accentColor: Color.fromRGBO(229, 247, 243, 1.0),
              cursorColor: Color.fromRGBO(0, 175, 136, 1.0)
              
              // focusColor: Color.fromRGBO(229,247,243, 1.0),
              ),
         initialRoute: jwt == null ? "Login" : "Main",//testing
          //         initialRoute: !login ? "Login" : "Main",//testinh for login screen

          //  initialRoute: "Main",
          // home: Login(),
          routes: <String, WidgetBuilder>{
            'Login': (BuildContext context) => new Login(),
            'LoginOtp': (BuildContext context) => new LoginOtp(),
            'Otp': (BuildContext context) => new Otp(),
            'Main': (BuildContext context) => new FirstScreen(),
            'Desc': (BuildContext context) => new Description(),
            'SignUp': (BuildContext context) => new SignUp(),
            'tab': (BuildContext context) => new f.TabScreen(),
            'up': (BuildContext context) => new UserProfile(),
            'manageProfile': (BuildContext context) => new ManageProfile(),
          }),
    );
  }
}
