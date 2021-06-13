import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grad_app/screens/components/TextFieldWithIcon.dart';
import 'package:grad_app/screens/components/bottomNavBar.dart';
import 'package:grad_app/screens/components/sideMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/PopUpDialog.dart';


String finalName,finalEmail,finalStudentPhone,finalParentPhone,finalBirthDate;
int finalId;
class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isloading=true;
  TextEditingController nameField;
  TextEditingController emailField;
  TextEditingController studentPhoneField;
  TextEditingController parentPhoneField;
  TextEditingController birthDateField;


  @override
  void initState()  {
    getdata().whenComplete(() async{

      // Timer(Duration(seconds: 2),
      //       () =>  print(finalName),
      // );
    }
    );
    super.initState();
    //  print(finalname);

  }
  Future getdata()async{
    final  sharedPreferences=await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('name');
    var email = sharedPreferences.getString('email');
    var studentPhone = sharedPreferences.getString('studentPhone');
    var parentPhone = sharedPreferences.getString('parentPhone');
    var birth_date = sharedPreferences.getString('birth_date');
    var id=sharedPreferences.getInt('id');
    setState((){
      finalName=name;
      finalEmail=email;
      finalStudentPhone=studentPhone;
      finalParentPhone=parentPhone;
      finalBirthDate=birth_date;
      finalId=id;


      setState(stoploading);
       nameField=TextEditingController(text:'$finalName');
       emailField=TextEditingController(text:'$finalEmail');
       studentPhoneField=TextEditingController(text:'$finalStudentPhone');
       parentPhoneField=TextEditingController(text:'$finalParentPhone');
       birthDateField=TextEditingController(text:'$finalBirthDate');
    }

    );
    // print(finalname);

  }
  void stoploading()
  {
    isloading=false;
  }





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF1E212D)),
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0,
         ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: size.width*0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                SizedBox(height: 30),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'),
                  radius: 70,
                ),

                SizedBox(height: 40,),

                TextField(
                  controller:nameField,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person)
                ),
                ),
                SizedBox(height: 35,),
                TextField(
                  controller:emailField,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email)
                  ),
                ),
                SizedBox(height: 35),
                TextField(
                  controller:studentPhoneField,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android_outlined)
                  ),
                ),
                SizedBox(height: 35),
                TextField(
                  controller:parentPhoneField,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone)
                  ),
                ),
                SizedBox(height: 35),
                TextField(
                  controller:birthDateField,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today_outlined)
                  ),
                ),

                SizedBox(height: 55),

                Row(
                  children: <Widget>[

                  Expanded(
                      flex: 3,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () => {Navigator.of(context).pushNamed('/profile')},
                        padding: EdgeInsets.all(15.0),
                        color: Color(0xFFECECEC),
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                            color:  Color(0xFF313131),
                            letterSpacing: 1.5,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                  ),
                  Spacer(flex:1
                  ),
                  Expanded(
                    flex: 5,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () async {

                        final Dio dio=new Dio();
                        Response res = await dio.put("http://localhost:8000/students/${finalId}/update",
                            data: {"name":nameField.text,"email":emailField.text, "birth_date":birthDateField.text,
                              "student_phone_number":studentPhoneField.text,"parent_phone_number":parentPhoneField.text},
                            options: Options(
                              headers: {},
                            ));
                        if(res.statusCode==200) {
                          //final data
                          Navigator.of(context).pushNamed('/profile');

                          showDialog(
                            context: context,
                            builder: (BuildContext context) => buildPopupDialog(context),
                          );
                          return res.data;
                        }
                        else
                        {
                          return res.statusCode;
                        }


                      },
                      padding: EdgeInsets.all(15.0),
                      color: Color(0xFF1E212D),
                      child: Text(
                        'SAVE CHANGES',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),)
                ],)

              ],),
          ),
        ),
      ),

      bottomNavigationBar: NavBar(),
    );

  }
}

Widget buildPopupDialog(BuildContext context) {
  return PopUpDialog(mainTitle: "Changes Saved",
      text: "Your Data Has Been Updated,Please Relogin To View Changes",screenName:'/login',actionName: "Logout",);
}


