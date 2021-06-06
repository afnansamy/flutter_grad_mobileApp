import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

import 'PopUpDialog.dart';

String finalName,finalCardlId;


class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String qrCode = 'Unknown';

  bool isloading = true;

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

  void stoploading() {
    isloading = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
            ),
          ),
          Container(
            height: size.height * 0.3 - 20,
            child: DrawerHeader(
              child: Text(
                'Side menu',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF1E212D),
                // image: DecorationImage(
                //     fit: BoxFit.contain,
                //     image: AssetImage('assets/images/cover.jpg'))
              ),
            ),
          ),
          // SizedBox(height: 50.0),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {Navigator.of(context).pushNamed('/home')},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pushNamed('/profile')},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () => {Navigator.of(context).pushNamed('/notification')},
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_sharp),
            title: Text('My Wallet'),
            onTap: () => {Navigator.of(context).pushNamed('/mywallet')},
          ),
          ListTile(
              leading: Icon(Icons.qr_code),
              title: Text('Scan QR'),
              onTap: () async {
                scanQRCode();


              }),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              final sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.remove('access_token');
              sharedPreferences.remove('refresh_token');
              sharedPreferences.remove('email');
              sharedPreferences.remove('name');
              sharedPreferences.remove('card_id');
              sharedPreferences.remove('studentPhone');
              sharedPreferences.remove('parentPhone');

              // var name= sharedPreferences.getString('name');
              //  print(name);

              Navigator.of(context).pushNamed('/login');
            },
          ),
        ],
      ),
    );
  }
  // Widget buildPopupDialog(BuildContext context) {
  //   return PopUpDialog(mainTitle: "Attendance recorded",
  //     text: "Your attendance has been recorded successfully  ",screenName:'/notification',actionName: "Ok",);
  // }
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
