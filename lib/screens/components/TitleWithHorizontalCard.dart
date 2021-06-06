import 'package:flutter/material.dart';
import 'package:grad_app/screens/components/HorizontalCard.dart';
import 'package:grad_app/screens/components/MainTitle.dart';

import 'dart:io';
//import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:http/http.dart';
class TitleWithHorizontalCard extends StatelessWidget {

  const TitleWithHorizontalCard({
    Key key,
    @required this.size, this.Maintitle,
  }) : super(key: key);

  final String Maintitle;

  final Size size;

  @override
  Widget build(BuildContext context) {

    // Future getData() async {
    //   Response response = await http.get('http://localhost:3004/labs/');
    //   //String name="name";
    //   // print(json.decode(response.body));
    //   Map data = json.decode(response.body);
    //  // return json.decode(response.body);
    //   return data;
    //   // ['results'];
    // }
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[





          MainTitle(Maintitle: Maintitle),
          SizedBox(height: 15),
          //hna loop for notifications


          HorizontalCard(size: size, Title: "Title of Notification 2 ", type: "SubTitle of notification 1 with lorem",time: "13-5-2011 10:24 PM",
            icon: Icon(Icons.notifications,),),
         // SizedBox(height: 15),
          HorizontalCard(size: size, Title: "Title of Notification 3 ", type: "SubTitle of notification 2 with lorem",time: "13-5-2011 10:24 PM",
            icon: Icon(Icons.notifications,),),
         // SizedBox(height: 15),
          HorizontalCard(size: size, Title: "Title of Notification 4 ", type: "SubTitle of notification 3 with lorem",time: "13-5-2011 10:24 PM",
            icon: Icon(Icons.notifications,),),
         // SizedBox(height: 15),


        ]);
  }
}




