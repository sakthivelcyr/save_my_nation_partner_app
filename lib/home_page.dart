import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_my_nation_partner_app/aboutus.dart';
import 'package:save_my_nation_partner_app/concerns.dart';
import 'package:save_my_nation_partner_app/dashboard.dart';
import 'package:save_my_nation_partner_app/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String url,name,email,professional,state,street,district,mobnum;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
      
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

void handleClick(String value) {
    switch (value) {
      case 'About Us':
       Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUs()),
                  );                  
        break;
      case 'Feedback':
      print('jl');
        break;
    }
}



  @override
  Widget build(BuildContext context) {   
    getData();    
    final List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    MyConcerns(),
    UserProfilePage(url,name,email,professional,state,street,district,mobnum),    
  ];
  //print(url);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        secondaryHeaderColor: Colors.black,
      ),
      home: WillPopScope(
        onWillPop: _onBackPressed,
              child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.white,        
          title: const Text('Save My Nation Partner',style: TextStyle(color:Colors.black87,fontSize: 20,fontWeight: FontWeight.bold,),),
          centerTitle: true,
          titleSpacing: 2.0,
          actions: <Widget>[
            PopupMenuButton<String>(            
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'About Us', 'Feedback'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    height: 35,
                    
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],     
          
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),

              title: Text('DashBoard'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.data_usage),
              title: Text('My Concerns'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              backgroundColor: Colors.blue,
              title: Text('Profile'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black38,
          onTap: _onItemTapped,
        ),
    ),
      ),
    );
  }
  void getData() async{  

  FirebaseUser user = await FirebaseAuth.instance.currentUser();  

  Firestore.instance.collection(user.email).snapshots().listen((data) => 
    data.documents.forEach((doc){
      url = doc ["image url"];
      name = doc ["name"];
      email = doc ["email"];
      professional = doc ["professional"];
      state = doc ["state"];
      street = doc ["street"];
      district = doc ["district"];
      mobnum = doc ["mobile number"];
    })
  );
  
}
Future<bool> _onBackPressed() {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      
      title: new Text('Are you sure?'),
      content: new Text('Do you want to exit an App'),
      actions: <Widget>[
        new GestureDetector(
          onTap: () => Navigator.of(context).pop(false),
          child: Text("NO"),
        ),
        SizedBox(height: 16),
        new GestureDetector(
          onTap: () => Navigator.of(context).pop(true),
          child: Text("YES"),
        ),
      ],
    ),
  ) ??
      false;
}
}



