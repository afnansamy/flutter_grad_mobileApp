import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grad_app/screens/components/bottomNavBar.dart';
import 'package:grad_app/screens/components/sideMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
//http: ^0.12.0+2
//dio: ^4.0.0

String finalName,finalEmail,finalCardId,finalStudentPhone,finalParentPhone,finalBirthDate;
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {

   bool isloading=true;


  @override
  void initState()  {
    getdata().whenComplete(() async{

      // Timer(Duration(seconds: 2),
      //       () =>  print(finalName),
      // );
    }
    );
    super.initState();

  }
  Future getdata()async{
    final  sharedPreferences=await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('name');
    var email = sharedPreferences.getString('email');
    var studentPhone = sharedPreferences.getString('studentPhone');
    var card_id = sharedPreferences.getString('card_id');
    var parentPhone = sharedPreferences.getString('parentPhone');
    var birth_date = sharedPreferences.getString('birth_date');
    setState((){
      finalName=name;
      finalEmail=email;
      finalStudentPhone=studentPhone;
      finalParentPhone=parentPhone;
      finalBirthDate=birth_date;
      finalCardId=card_id;
      setState(stoploading);
    }
    );

  }
   void stoploading()
   {
     isloading=false;
   }


  @override
  Widget build(BuildContext context)   {


    //initState();
   // print(students);

    Size size = MediaQuery.of(context).size;
    return Scaffold(

      drawer: NavDrawer(),
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF1E212D)),
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/editprofile');
                  },
                  child: Text(
                    'Edit',
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
          child: Container(
            width: size.width*0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                SizedBox(height: 30),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'),
                  radius: 70,
                ),

                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                    Expanded(
                      flex: 2,
                      child: Icon(Icons.person,
                        color: Color(0xFF777A7D),),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 8,
                      child: isloading ? Text("isloading") : Text(finalName,
                        style: TextStyle(
                          color: Color(0xFF777A7D),
                          fontSize: 20.0,
                          fontFamily: 'roboto',
                        ),),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                    Expanded(
                      flex: 2,
                      child: Icon(Icons.credit_card,
                        color: Color(0xFF777A7D),),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 8,
                      child: isloading ? Text("isloading") : Text(finalCardId,
                        style: TextStyle(
                          color: Color(0xFF777A7D),
                          fontSize: 20.0,
                          fontFamily: 'roboto',
                        ),),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Icon(Icons.mail,
                        color: Color(0xFF777A7D),),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 8,
                      child: isloading ? Text("isloading") : Text(finalEmail,
                        style: TextStyle(
                          color: Color(0xFF777A7D),
                          fontSize: 20.0,
                          fontFamily: 'roboto',
                        ),),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Expanded(
                      flex: 2,
                      child: Icon(Icons.phone_android_outlined,
                        color: Color(0xFF777A7D),),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 8,
                      child: isloading ? Text("isloading") : Text(finalStudentPhone,
                        style: TextStyle(
                          color: Color(0xFF777A7D),
                          fontSize: 20.0,
                          fontFamily: 'roboto',
                        ),),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                    Expanded(
                      flex: 2,
                      child: Icon(Icons.phone,
                        color: Color(0xFF777A7D),),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 8,
                      child: isloading ? Text("isloading") : Text(finalParentPhone,
                        style: TextStyle(
                          color: Color(0xFF777A7D),
                          fontSize: 20.0,
                          fontFamily: 'roboto',
                        ),),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                    Expanded(
                      flex: 2,
                      child: Icon(Icons.calendar_today_outlined,
                        color: Color(0xFF777A7D),),
                    ),
                    //Spacer(),
                    Expanded(
                      flex: 8,
                      child: isloading ? Text("isloading") : Text(finalBirthDate,
                        style: TextStyle(
                          color: Color(0xFF777A7D),
                          fontSize: 20.0,
                          fontFamily: 'roboto',
                        ),),
                    ),
                  ],
                ),

              ],),
          ),
        ),
      ),

      bottomNavigationBar: NavBar(),
    );
  }

}

class Student{
  final String card_id,fcm_code,name,email,password,birth_date,student_phone_number,parent_phone_number;


  Student(this.name, this.email, this.student_phone_number, this.card_id, this.fcm_code, this.password, this.birth_date, this.parent_phone_number);

   Student.fromJson(Map<String,dynamic> json)
       :card_id=json['card_id'] ?? '',
        fcm_code=json['fcm_code'] ??'',
        name=json['name'] ?? '',
        email=json['email'] ?? '',
        password=json['password'] ?? '',
        birth_date=json['birth_date'] ?? '',
        student_phone_number=json['student_phone_number'] ?? '',
        parent_phone_number=json['parent_phone_number'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'card_id': card_id,
      'fcm_code': fcm_code,
      'name': name,
      'email': email,
      'password': password,
      'birth_date': birth_date,
      'student_phone_number': student_phone_number,
      'parent_phone_number': parent_phone_number,

    };
  }
}