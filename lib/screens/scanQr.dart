import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:grad_app/screens/components/bottomNavBar.dart';
import 'package:grad_app/screens/components/sideMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/MainTitle.dart';
import 'components/PopUpDialog.dart';

String finalName,finalCardlId;
//TODO::mnnsaash n ncall el screen de fe el side menu (navigator.push(el screen de))
class QrScreen extends StatefulWidget {
  @override
  _QrScreenState createState() => _QrScreenState();
}


class _QrScreenState extends State<QrScreen> {

  bool isloading=true;
  String qrCode = 'Unknown';


  @override
  void initState() {
    getdata().whenComplete(() async {});
    super.initState();
  }
  Future getdata() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('name');
    var card_id = sharedPreferences.getString('card_id');
    setState(() {
      finalName = name;
      finalCardlId = card_id;
      setState(stoploading);
    });
  }
  void stoploading()
  {
    isloading=false;
  }


  @override
  Widget build(BuildContext context)   {
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
                   // Navigator.of(context).pushNamed('/editprofile');
                  },
                  child: Text(
                    'Report a problem',
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image(
                //   //
                //     image: AssetImage('assets/images/QR.png',),
                //
                // ),
                SizedBox(height: 50,),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 15.0),
                  child: Container(child: Image.asset('assets/images/QR.png',width: 275,height:180, fit: BoxFit.fitWidth,)),
                ),
                SizedBox(height: 20,),
                MainTitle(Maintitle: "Record your attendance"),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Text("Now scanning your attendance has never been easier,"
                      "Just click the button below and your attendance will be recorded  ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 15.0,
                      letterSpacing: 1.0,
                      fontFamily: 'roboto',
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 40,right: 40),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 25.0),
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: ()async
                      {
                        scanQRCode();
                      },
                      padding: EdgeInsets.all(15.0),
                      color: Color(0xFF1E212D),
                      child: Text(
                        'SCAN QR',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                )
              ],),
          ),
        ),
      ),

      bottomNavigationBar: NavBar(),
    );
  }
  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );


      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
      final Dio dio = new Dio();
      Response res = await dio.post(
          "http://127.0.0.1:8000/lectures/record_attendance",
          data: {
            "lecture_id": qrCode,
            "student_id": finalCardlId,
            "student_name": finalName
          },
          options: Options(
            headers: {},
          ));
      if (res.statusCode == 200) {
        Navigator.of(context).pushNamed('/home');
        Timer.run(() {
          showDialog(
            context: context,
            builder: (_) =>  PopUpDialog(mainTitle: "Attendance recorded",
              text: "Your attendance has been recorded successfully  ",screenName:'/home',actionName: "Ok",),
          );
        });

      } else {
        return res.statusCode;
      }


    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }

}




