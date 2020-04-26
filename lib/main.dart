import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:save_my_nation_partner_app/Intro1.dart';
import 'package:save_my_nation_partner_app/home_page.dart';
import 'package:save_my_nation_partner_app/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  //SystemChrome.setEnabledSystemUIOverlays([]);
   WidgetsFlutterBinding.ensureInitialized();
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomePage': (BuildContext context) => new HomePage(),  //Homepage
      '/WelcomePage': (BuildContext context) => new Login(),
    },
  ));
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    var _duration = new Duration(seconds: 2);
    if (firstTime != null && !firstTime) {// Not first time
      return new Timer(_duration, navigationPageHome);
    } else {// First time
      
      return new Timer(_duration, navigationPageWel);
    }
  }
  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed('/HomePage');
  }

  void navigationPageWel() {

    Navigator.of(context).pushReplacementNamed('/WelcomePage');
  }

 @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;    
    double wt = screenSize.width;
    TextStyle ts = TextStyle(
      fontSize: wt/10,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      letterSpacing: 1,
    );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: bd,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Save My Nation',
                  style: ts,
                  ),
                  Text('Partner',
                  style: ts,
                  ),
                ],
              ),
            ),
          ),          
        ],
      ),
    );
  }
  }

