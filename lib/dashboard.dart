import 'package:flutter/material.dart';


class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

      class _DashBoardState extends State<DashBoard> {
        Widget getWidget(double ht, double wt, LinearGradient lg,String num, String tit) {
            return Container(
                height: wt/2.6,
                width: wt/2.6,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black87,width: 2),
                gradient: lg,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(num,style: TextStyle(color:Colors.white,fontSize: wt/12),),
                    SizedBox(height: ht/160,),
                    Text(tit,style: TextStyle(color:Colors.black,fontSize: wt/22)),
                  ],
                ),
                //color: Colors.orange,
               );
      }

      Widget getRow(double ht, double wt,LinearGradient lg1, LinearGradient lg2) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[              
                getWidget(ht, wt,lg1,'52','Today Concerns'),
                getWidget(ht, wt,lg2,'5412','Total Concerns'),              
              ],
            );
      }

  LinearGradient lg1 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.green[600],Colors.green[400] ,Colors.green[600]],
  );
  LinearGradient lg2 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.blue[600],Colors.blue[400] ,Colors.blue[600]],
  );
  LinearGradient lg3 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.orange[600],Colors.orange[400] ,Colors.orange[600]],
  );

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double ht = queryData.size.height;
    double wt = queryData.size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: ht/20,),                 
          getRow(ht, wt,lg1,lg2),
          SizedBox(height: wt/15,),
          getRow(ht, wt,lg2,lg1),

        ],
      ),      
    );
  }
}

