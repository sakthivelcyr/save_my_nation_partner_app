import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final String url = "https://tailermade.com/savemynation/api/v1/savemynation/state";
  String _mySelection;
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
    return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('sak'),
            ),
        body: FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.supervisor_account, color: Colors.deepOrange, size: 25.0),
                             contentPadding: EdgeInsets.fromLTRB(0, 18, 0, 16.0),
                             ),
                          //isEmpty: _color == '',
                          child: new DropdownButtonHideUnderline(

          child: new DropdownButton(
            hint: new Text("Customer ID"),
            isDense: true,
            items: data.map((item) {
              return new DropdownMenuItem(
                child: new Text(item),                
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _mySelection = newVal;
              });
            },
            value: _mySelection,
          ),
       
       ),
                        );
                      },
                    ),

      ),
    );
  }
}                  