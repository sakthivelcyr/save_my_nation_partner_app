import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_my_nation_partner_app/intro3.dart';
import 'package:save_my_nation_partner_app/shared.dart';

class NameandMobile extends StatefulWidget {
  @override
  _NameandMobileState createState() => _NameandMobileState();
}

class _NameandMobileState extends State<NameandMobile> {
  var f=0;
  final db = Firestore.instance;
  //final ntext = TextEditingController();
  bool _validaten = false;
  bool _validatem = false;
  String name,mobno;
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double ht = queryData.size.height;
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
                SizedBox(height: ht/10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: TextFormField(
                onChanged: (value){
                  name = value;
                },
                decoration: id.copyWith(labelText: 'Name',errorText: _validaten ? 'Name must contains atleast 4 characters' : null),
              ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: TextFormField(                  
                  keyboardType: TextInputType.number,
                onChanged: (value){
                  mobno = value;
                },
                decoration: id.copyWith(labelText: 'Mobile Number',errorText: _validatem ? 'Invalid Mobile Number' : null,),
              ),
              ),
              SizedBox(height: ht/30,),
              RaisedButton(
                onPressed: (){
                  print('pressed');
                  setState(() {                    
                    if(name==null || name.length<4){
                      _validatem = false;
                      _validaten = true;
                      f = 1;
                    }
                    else if(mobno==null || (mobno.length<10)) {
                      _validatem = true;
                      _validaten = false;
                      f =1;
                    }
                    else {
                      storeData();
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Address()),
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
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    //print(_user.email ?? "None");
    await db.collection(_user.email).document('Personal Details').updateData({
      'name': name,
      'mobile number' : mobno
    });
    //print(name);
  }
}
