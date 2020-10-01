import 'package:flutter/material.dart';
import './pages/home_page.dart';
//import './pages/intro_screen.dart';
import './pages/splash_screen.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
  //"/intro": (BuildContext context) => IntroScreen(),
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xFF5e17eb), accentColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: routes);
  }
}
