import 'package:flutter/material.dart';
import 'package:meatapp/screens/animate.dart';
import 'package:meatapp/screens/login.dart';
import 'short.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:Home(), 
        routes: <String, WidgetBuilder>{
          'Login': (BuildContext context) => new Login(),
           'LoginA': (BuildContext context) => new LoginA(),

          //   'Main':(BuildContext context)=> new Main(),
          //  'Dewsc': (BuildContext context) => new Desc(),
        });
  }
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
          appBar: AppBar(
            title: Text("Routes"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, "Login"),
                    child: Text("Login")),
                RaisedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, "LoginA"),
                    child: Text("Main")),
                RaisedButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, "Desc"),
                    child: Text("Desc")),
              ],
            ),
          ),
        );
  }
}