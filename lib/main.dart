import 'package:flutter/material.dart';
import 'package:meatapp/screens/Description.dart';
import 'package:meatapp/screens/FirestScreen.dart';
import 'package:meatapp/screens/entry/Otp.dart';
import 'package:meatapp/screens/entry/Login.dart';
import 'package:meatapp/screens/entry/loginOtp.dart';
import 'screens/entry/Signup.dart';
import 'screens/tabScreen.dart'as f;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Sans',
              ),
          // fontFamily: ,
          primarySwatch: Colors.blue,
        ),
        home: Login(),
        routes: <String, WidgetBuilder>{
          'Login': (BuildContext context) => new Login(),
          'LoginOtp': (BuildContext context) => new LoginOtp(),
          'Otp': (BuildContext context) => new Otp(),
          'Main': (BuildContext context) => new FirstScreen(),
          'Desc': (BuildContext context) => new Description(),
          'SignUp': (BuildContext context) => new SignUp(),
          'tab': (BuildContext context) => new f.TabScreen(),
        });
  }
}

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Routes"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             RaisedButton(
//                 onPressed: () =>Navigator.pushReplacementNamed(context, "Login"),
//                 child: Text("Login")),
//             RaisedButton(
//                 onPressed: () =>Navigator.pushReplacementNamed(context, "Login"),
//                 child: Text("AnimatedLogin")),
//             RaisedButton(
//                 onPressed: () =>
//                     Navigator.pushReplacementNamed(context, "Main"),
//                 child: Text("FirstScreen")),
//           ],
//         ),
//       ),
//     );
//   }
// }
