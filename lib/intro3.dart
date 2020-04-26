import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_my_nation_partner_app/intro4.dart';
import 'package:save_my_nation_partner_app/shared.dart';
import 'package:http/http.dart' as http;

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  String errD = '';
  bool _validates = false;
  String errS = '';
  String _dropDownDistrictValue,_dropDownStateValue;
  final db = Firestore.instance;
  String street, district, state;

  final String url = "https://tailermade.com/savemynation/api/v1/savemynation/state";
  var serverip = TextEditingController(text: '192.168.1.40');
  List data = List();  
  Future<String> getSWData() async {  
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body)['state'];    
    List<String> tags = resBody != null ? List.from(resBody) : null;
    setState(() {
    data = tags;  
    });    
    return "Sucess";

  }
  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
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
                height: ht/40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: TextFormField(
                  autofocus: false,
                  autovalidate: true,
                  
                  keyboardType: TextInputType.multiline,
                onChanged: (value){
                  street = value;
                },
                decoration: id.copyWith(labelText: 'Street',errorText: _validates ? 'Street must contains atleast 6 characters' : null),
              ),
              ),            
              
              SizedBox(height: wt/20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: Colors.black,width: 2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(

                      hint: _dropDownStateValue == null
                          ? Text('State')
                          : Text(
                        _dropDownStateValue,
                        style: TextStyle(color: Colors.white),
                      ),
                      isExpanded: true,
                      
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      isDense: false,                      
                      items: data.map(
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
                            _dropDownStateValue = val;
                            state = val;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: wt/60,),
              Text(errS,
              textAlign: TextAlign.start,              
              style: TextStyle(
                color: Colors.red,
                                
              ),),
              SizedBox(height: wt/40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(color: Colors.black,width: 2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(


                      hint: _dropDownDistrictValue == null
                          ? Text('District')
                          : Text(
                        _dropDownDistrictValue,
                        style: TextStyle(color: Colors.white),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: TextStyle(color: Colors.black),
                      items: ['Chennai', 'Trichy', 'Madurai'].map(
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
                            _dropDownDistrictValue = val;
                            district = val;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: wt/40,),
              Text(errD,
              textAlign: TextAlign.start,              
              style: TextStyle(
                color: Colors.red,
                                
              ),),
              
              
              SizedBox(height: wt/25,),
              RaisedButton(
                onPressed: (){
                  setState(() {
                    if(street==null || street.length<6){
                      _validates = true;                                            
                    }
                    else if(_dropDownDistrictValue == null && _dropDownStateValue == null) {
                      _validates = false;                      
                      errD = 'Please enter your district.';                      
                      errS = 'Please enter your State.';
                    }
                    else if(_dropDownDistrictValue == null) {
                      _validates = false;                      
                      errD = 'Please enter your district.';    
                      errS = '';                  
                    }
                    else if(_dropDownStateValue == null) {
                      _validates = false;                      
                      errS = 'Please enter your State.';
                      errD = '';
                    }
                    /*else if(_dropDownStateValue != null) {
                      _validates = false;                      
                      errS = '';
                    }  */                   
                    else {
                      print('object');
                      storeData();
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Profession()),
                  );                  
                    }
                  });
                  
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
    //print(district+state+street);
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    //print(_user.email ?? "None");
    await db.collection(_user.email).document('Personal Details').updateData({
      'street': street,
      'district' : district,
      'state' : state,
    });
        
  }
}

