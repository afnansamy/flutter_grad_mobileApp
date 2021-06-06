import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grad_app/screens/components/TitleWithHorizontalCard.dart';
import 'package:grad_app/screens/components/sideMenu.dart';

import 'components/bottomNavBar.dart';


import 'dart:io';
//import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

 //String finalname;

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  // @override
  // void initState()  {
  //   getdata().whenComplete(() async{
  //
  //     Timer(Duration(seconds: 2),
  //           () =>  print(finalname),
  //     );
  //   }
  //   );
  //   super.initState();
  //   //print(finalname);
  //
  // }
  // Future getdata()async{
  //   final  sharedPreferences=await SharedPreferences.getInstance();
  //   var name = sharedPreferences.getString('name');
  //   setState((){
  //     finalname=name;
  //   }
  //   );
  //  // print(finalname);
  //
  // }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF1E212D)),
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0,
          // leading: IconButton(
          //     icon: Icon(
          //       Icons.menu_rounded,
          //       color: Color(0xFF1E212D),
          //     ),
          //     onPressed: () {}),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Mark as read',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF1E212D),
                    ),
                  )),
            ),
          ]),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 15),
              TitleWithHorizontalCard(
                  size: size, Maintitle: "New Notifications"),
              SizedBox(height: 15),
              TitleWithHorizontalCard(
                  size: size, Maintitle: "Old Notifications"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
