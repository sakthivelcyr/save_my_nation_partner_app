import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:save_my_nation_partner_app/first_screen.dart';
import 'package:save_my_nation_partner_app/shared.dart';
import 'package:save_my_nation_partner_app/sign_in.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
Position position;
class _LoginState extends State<Login> {
 

final Location location = Location();
bool _serviceEnabled;
PermissionStatus _permissionGranted;
LocationData _locationData;

void getLocation() async {
_serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
    return;
  }
}
_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
}

_locationData = await location.getLocation();
print(_locationData.latitude);
}



  @override
  Widget build(BuildContext context) {
    getLocation();
    MediaQueryData queryData = MediaQuery.of(context);
    double ht = queryData.size.height;
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        body: Container(
          height: ht,
          width: queryData.size.width,
          decoration: bd,
          child: Column(
            children: <Widget>[
              Container(
                height: ht/2,
                child: img()),              
                SizedBox(
                  height: ht/2.5,
                ),
              Container(                               
                child: _signInButton())
            ],
          ),
        ),
      ),
    );
  }
  Widget _signInButton() {
    return OutlineButton(
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          if(name==null) {
            Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return Login();
              },
            ),
          );
          }
          else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return FirstScreen();
              },
            ),
          );  
          }
          
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,      
      borderSide: BorderSide(color: Colors.black,width: 2),
      child: Padding(        
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Sign in with Google',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
