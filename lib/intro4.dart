import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:save_my_nation_partner_app/home_page.dart';
import 'package:save_my_nation_partner_app/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Profession extends StatefulWidget {
  @override
  _ProfessionState createState() => _ProfessionState();
}


double latitude,longitude;
class _ProfessionState extends State<Profession> {
final Location location = Location();
var f=0;
String errP = '';
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

  /*
You can also get continuous callbacks when your position is changing:

location.onLocationChanged.listen((LocationData currentLocation) {
  // Use current location
});

  */
}

_locationData = await location.getLocation();
print(_locationData.latitude);
latitude = _locationData.latitude;
longitude = _locationData.longitude;
}
    
  final db = Firestore.instance;
  String _dropDownValue;
  @override
  Widget build(BuildContext context) {
    getLocation();
    MediaQueryData queryData = MediaQuery.of(context);
    double ht = queryData.size.height;
    double wt = queryData.size.width;
    return Scaffold(
      body:Container(
        decoration: bd,
        height: ht,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: ht/2,
                child: img()),        
              SizedBox(
                height: ht/5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: Colors.black,width: 2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: DropdownButton(
                      hint: _dropDownValue == null
                          ? Text('Select your Professional')
                          : Text(
                        _dropDownValue,
                        style: TextStyle(color: Colors.white),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      items: ['Medical Professional', 'Working Professional', 'Business Professional', 'Student', 'other'].map(
                            (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                              () {
                            _dropDownValue = val;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: wt/40,),
              Text(errP,
              textAlign: TextAlign.start,              
              style: TextStyle(
                color: Colors.red,
                                
              ),),
              SizedBox(height: wt/25,),
              RaisedButton(
                onPressed: () async{
                  setState(() {
                    if(_dropDownValue == null) {
                      errP = 'Please select your Profession.';
                    }
                    else {
                      f=1;
                    }                    
                  });
                  if(f==1) {
                      storeData();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('first_time', false);
                      print('bool value changed');
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );                  
                    }                  
                },
                shape: rrb,
                color: Colors.lightBlueAccent,
                padding: EdgeInsets.symmetric(horizontal: 45,vertical: 10),
                child: tNext,
              ),
            ],
          ),
        ),
      ),
    );
  }
  storeData() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    //print(_user.email ?? "None");
    await db.collection(_user.email).document('Personal Details').updateData({
      'professional': _dropDownValue,
      'latitude' :  latitude,
      'longitude' : longitude,
    });
        
  }
}
