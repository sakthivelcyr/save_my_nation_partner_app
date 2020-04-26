import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:save_my_nation_partner_app/loading.dart';
import 'package:save_my_nation_partner_app/view.dart';

class MyConcerns extends StatefulWidget {
  @override
  _MyConcernsState createState() => _MyConcernsState();
}
String documentId,surl,sname,semail,sprofessional,sstate,sstreet,sdistrict,smobnum,simageurl,srequirement;
double slatitude,slongitude;
class _MyConcernsState extends State<MyConcerns> {
  bool loading = false;
   Future<String> getData(String d) async{  
await Firestore.instance
        .collection('Concerns/Thiruvannamalai/604407')
        .document(d)
        .get()
        .then((DocumentSnapshot ds) {

          surl = ds ["image url"];
      sname = ds ["name"];
      //email = ds ["email"];
      sprofessional = ds ["professional"];
      sstate = ds ["state"];
      sstreet = ds ["street"];
      sdistrict = ds ["district"]; 
      simageurl = ds ["imageurl"];     
      slatitude = ds["latitude"];
      slongitude = ds["longitude"];
      srequirement = ds["requirement"];
      smobnum = ds ["mobno"];
        //print(ds.data);  
      // use ds as a snapshot
    }); 
    return '$d';
}
  final Distance distance = new Distance();
  @override
  Widget build(BuildContext context) {
    
    
    
    MediaQueryData queryData = MediaQuery.of(context);
    double ht = queryData.size.height;
    double wt = queryData.size.width;

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('Concerns')
          .document('Thiruvannamalai')
          .collection('604407')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Loading();
          default:
            return  loading ? Loading()
                    :  new ListView(
              children:
              snapshot.data.documents.map((DocumentSnapshot document) {                    
                final double km = distance.as(LengthUnit.Kilometer,
                new LatLng(document['latitude'],document['longitude']),new LatLng(10.0789867,78.4207106));    
    
                int km1 =  km.toInt();
                return new Padding(
                  padding: const EdgeInsets.only(
                      top: 9.0, left: 12.0, right: 12.0, bottom: 0.0),
                  child: new Card( 
                                  
                    borderOnForeground: true,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    ),
   
                    color: Colors.white,
                    child: InkWell(
                      onTap: () async{                       
                        setState(()=> loading =true);                        
                       dynamic c = await getData(document.documentID);
                       if(c==document.documentID) {
                          setState(()=> loading =false);
                          Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewPage(document.documentID,surl,sname,semail,sprofessional,sstate,sstreet,sdistrict,smobnum,simageurl,srequirement,slatitude,slongitude)),
                  );
                        }                       
                      },
                                          child: Padding(
 padding: EdgeInsets.all(7),
 child: Stack(
 children: <Widget>[
   Padding(
       padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Container(
      width: wt/5,
      height: wt/5,
      decoration: BoxDecoration(
    image: DecorationImage(
      image: NetworkImage(document['imageurl']),
      fit: BoxFit.cover,
    ),
    borderRadius: BorderRadius.circular(80.0),
    border: Border.all(
      color: Colors.white,
      width: 1.0,
    ),
      ),
    ),
           
           SizedBox(width: wt/18,),
           
           Column(
             
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               
               Text(document['name'],
               style: TextStyle(
                 
                color: Colors.black,
                fontSize: wt/22,
                fontWeight: FontWeight.w700,
               ),),
               SizedBox(height: wt/400,),
               Text(document['requirement'],
               style: TextStyle(
                 fontFamily: 'Roboto',
                color: Colors.black,
                fontSize: wt/25,
                fontWeight: FontWeight.w500,
               ),),
               SizedBox(height: ht/150,),
               Text(document['street'],
               style: TextStyle(
                 fontFamily: 'Roboto',
                color: Colors.black,
                fontSize: wt/27,
                fontWeight: FontWeight.w400,
               ),),
               SizedBox(height: ht/150,),
               Row(
                 children: <Widget>[
                   Icon(
                     Icons.location_on,
                     size: wt/18,
                   ),
                   SizedBox(width: wt/100,),
                   Text("$km1 km",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontSize: wt/27,
                      fontWeight: FontWeight.w400,
               ),),
                 ],
               ),                             
             ],
           ),
         ],
       ))
 ]),
),
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
  Widget putWidget(String str, String dis) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 12.0, left: 20.0, top: 12.0, bottom: 0.0),
      child: Row(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              str,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            dis,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
  
 Future<Null> _submitDialog(BuildContext context) async {
  return await showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        );
      });
}
}

