import 'package:flutter/material.dart';
import 'package:grad_app/screens/components/body.dart';
import 'package:grad_app/screens/components/bottomNavBar.dart';
import 'package:grad_app/screens/components/sideMenu.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: NavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor:  Color(0xFF1E212D),
      elevation: 0,
    );
  }
}