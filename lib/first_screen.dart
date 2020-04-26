import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_my_nation_partner_app/Intro1.dart';
import 'package:save_my_nation_partner_app/intro2.dart';
import 'package:save_my_nation_partner_app/shared.dart';
import 'package:save_my_nation_partner_app/sign_in.dart';


class FirstScreen extends StatelessWidget {
  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {   
    print(name);    
    if(name==null){
      print('no');
      Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
    }
    MediaQueryData queryData = MediaQuery.of(context);
    double wt = queryData.size.width;
    return Scaffold(
      body: Container(
        decoration: bd,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: wt/18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown),
              ),
              SizedBox(height: wt/120,),
              Text(
                name,
                style: TextStyle(
                    fontSize: wt/15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: wt/20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: wt/18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown),
              ),
              SizedBox(height: 10),
              Text(
                email,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: wt/17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  storeData();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NameandMobile()),
                  );
                },
                color: Colors.lightBlueAccent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:8,horizontal: 30),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: rrb,
              )
            ],
          ),
        ),
      ),
    );
  }
  storeData() async {
    //print(name+email+imageUrl);
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    //print(_user.email ?? "None");
    await db.collection(_user.email).document('Personal Details').setData({
      'E-mail name': name,
      'image url' : imageUrl,
      'email': email,
    });
        
  }
}

