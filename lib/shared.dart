import 'package:flutter/material.dart';

var id = new InputDecoration(
     enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Colors.black,width: 2)),
     focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Colors.white,width: 2)), 
     errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Colors.red,width: 1)), 

     
   );
var bd = BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[600],Colors.blue[500] ,Colors.blue[700]],
          ),
        );

Widget img() {
  return Padding(
            padding: const EdgeInsets.only(top:60.0,left: 15,right: 15),
            child: Image.asset('assets/v6.png',),
  );
}


RoundedRectangleBorder rrb= RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  side: BorderSide(color: Colors.black,width: 2),
          );

Text tNext =Text('Next',style: TextStyle(fontSize: 16.0,color: Colors.white,fontWeight: FontWeight.w700),);