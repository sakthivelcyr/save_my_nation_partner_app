import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:save_my_nation_partner_app/shared.dart';

class ViewPage extends StatefulWidget {
  final documentId,url,name,email,professional,state,street,district,mobnum,imageurl,requirement,latitude,longitude;
  ViewPage(this.documentId,this.url,this.name,this.email,this.professional,this.state,this.street,this.district,this.mobnum,this.imageurl,this.requirement,this.latitude,this.longitude);
  
  @override
  _ViewPageState createState() => _ViewPageState(documentId,url,name,email,professional,state,street,district,mobnum,imageurl,requirement,latitude,longitude);
}

class _ViewPageState extends State<ViewPage> {
  final documentId,url,name,email,professional,state,street,district,mobnum,imageurl,requirement,latitude,longitude;
  _ViewPageState(this.documentId,this.url,this.name,this.email,this.professional,this.state,this.street,this.district,this.mobnum,this.imageurl,this.requirement,this.latitude,this.longitude);
  

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double ht = queryData.size.height;
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(        
        appBar: AppBar(
          title: Text(name),
           automaticallyImplyLeading: true,
           leading: IconButton(
             icon:Icon(Icons.arrow_back),
             onPressed: ()=> Navigator.pop(context, false),
             ),
        ),
        body: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Container(
                height: ht*(1.2/3),
                child: MapView(latitude,longitude),                           
              ),
              Container(
                height: ht*(2/3),
                width: queryData.size.width,
                padding: EdgeInsets.only(top:20),
                child: DetailsView(ht,queryData.size.width,district,imageurl,mobnum,documentId,name,requirement,state,street,professional),
                
                color: Colors.white,                
                
              ),            
            ],
          ),
        ),
      ),      
    );
  }
  
}


class MapView extends StatefulWidget {
  final latitude,longitude;
  MapView(this.latitude,this.longitude);
  @override
  _MapViewState createState() => _MapViewState(latitude,longitude);
}

class _MapViewState extends State<MapView> {
    final latitude,longitude;
  _MapViewState(this.latitude,this.longitude);
  Completer<GoogleMapController> _controller = Completer();


  
  
  @override
  Widget build(BuildContext context) {
    final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      
      target: LatLng(latitude, longitude),
      tilt: 5,
      zoom: 17.151926040649414);
   // print(latitude);
    return Scaffold(
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: (){
          MapsLauncher.launchCoordinates(latitude,longitude);
        },    
        isExtended: true,
        label: Text('Close Location'),
        icon: Icon(Icons.directions_walk),
      ),
        
      body: GoogleMap(
         zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapToolbarEnabled: false,
        compassEnabled: true,       
        mapType: MapType.normal,
        initialCameraPosition: _kLake,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          
        },
      ),
      
    );
  }

  }


class DetailsView extends StatefulWidget {
  final ht,wt,district,imageurl,mobno,email,name,requirement,state,street,professional;
  DetailsView(this.ht,this.wt,this.district,this.imageurl,this.mobno,this.email,this.name,this.requirement,this.street,this.state,this.professional);
  @override
  _DetailsViewState createState() => _DetailsViewState(ht,wt,district,imageurl,mobno,email,name,requirement,state,street,professional);
}

class _DetailsViewState extends State<DetailsView> {
  String _dropDownValue;
  final ht,wt,district,imageurl,mobno,email,name,requirement,state,street,professional;
  _DetailsViewState(this.ht,this.wt,this.district,this.imageurl,this.mobno,this.email,this.name,this.requirement,this.street,this.state,this.professional);
  Widget _buildSeparator() {
    return Container(
      width: wt,
      height: 0.5,
      color: Colors.black12,
      margin: EdgeInsets.only(top: 4.0),
    );
  }
  Widget _buildProfileImage(double ht,double wt) {
  //print(name);
    return Center(
      child: Container(
        width: wt/5.5,
        height: wt/5.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageurl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(60.0),
          border: Border.all(            
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
    );
  }
  Widget service() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:60,vertical: 0),
      child: Container(      
        height: wt/10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.black,width: 2)
        ),
        child: Padding(          
          padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 0),
          child: DropdownButton(
          hint: _dropDownValue == null
            ? Text('Not serviced')
            : Text(
               _dropDownValue,
               style: TextStyle(color: Colors.black),
              ),                        
              
              underline: Text(''),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: ['Serviced','Not serviced'].map(
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
                  //print(val);
                  },
                );
              },
            ),
        ),
      ),
    );
  }
  Widget getWidget(String txt, Color clr, FontWeight ft, double fs) {
    return Padding(
              padding: const EdgeInsets.only(left:18.0),
              child: Text(txt,
              style: TextStyle(
                fontSize: fs,
                fontWeight: ft,
                color: clr,
              ),
              ),
            );
  }
  @override
  Widget build(BuildContext context) {
    return Column(      
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[  
            _buildSeparator(), 
            SizedBox(height:wt/50),       
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:15),
                  child: _buildProfileImage(ht, wt),
                ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        SizedBox(height:wt/40),
                        getWidget(name, Colors.black, FontWeight.w700, wt/18),
                        SizedBox(height:wt/120),
                        getWidget(professional, Colors.black87, FontWeight.w500, wt/23),
                    ],
                  ),
              ],
            ),            
            SizedBox(height:wt/50),
            _buildSeparator(),
            SizedBox(height:wt/30),
            Padding(
              padding: const EdgeInsets.only(left:5.0),
              child: Row(
                children: <Widget>[
                  getWidget('Need ', Colors.black87, FontWeight.w500, wt/22),
                  getWidget(requirement, Colors.black54, FontWeight.w500, wt/22),
                ],
              ),
            ),            
            SizedBox(height:wt/30),
            _buildSeparator(),
            SizedBox(height:wt/30),            
            Padding(
              padding: const EdgeInsets.only(left:5.0),
              child: getWidget('Address', Colors.black87, FontWeight.w500, wt/22),
            ),
            SizedBox(height:wt/150),            
            Padding(
              padding: const EdgeInsets.only(left:18.0,bottom: 2),
              child: getWidget(street, Colors.black54, FontWeight.w500, wt/25),
            ),
            Padding(
              padding: const EdgeInsets.only(left:18.0,bottom: 2),
              child: getWidget(district, Colors.black54, FontWeight.w500, wt/25),
            ),
            Padding(
              padding: const EdgeInsets.only(left:18.0),
              child: getWidget(state, Colors.black54, FontWeight.w500, wt/25),
            ),
            SizedBox(height:wt/30),            
            _buildSeparator(),
            SizedBox(height:wt/30),
            Padding(
              padding: const EdgeInsets.only(left:5.0),
              child: getWidget('Contact', Colors.black87, FontWeight.w500, wt/22),
            ),
            SizedBox(height:wt/150),            
            Padding(
              padding: const EdgeInsets.only(left:18.0,bottom: 2),
              child: getWidget(mobno, Colors.black54, FontWeight.w500, wt/25),
            ),
            Padding(
              padding: const EdgeInsets.only(left:18.0),
              child: getWidget(email, Colors.black54, FontWeight.w500, wt/25),            
            ),
            SizedBox(height:wt/30),
            _buildSeparator(),   
            SizedBox(height:wt/30),
            Padding(
              padding: const EdgeInsets.only(left:5.0),
              child: getWidget('Status', Colors.black87, FontWeight.w500, wt/22),
            ),
            SizedBox(height:wt/40),
            service(),
            SizedBox(height:wt/40),
            Container(
              width: wt,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[                  
                  RaisedButton(
                      onPressed: (){  },
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  side: BorderSide(color: Colors.blue,width: 2.5),
                  ),
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                      child: Text('Change Status',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w500,letterSpacing: 0.7),),
                    ),
                ],
              ),
            ),
          ],          
        );
  }
}
