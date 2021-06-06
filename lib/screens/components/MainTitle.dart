import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({
    Key key,
    @required this.Maintitle,
  }) : super(key: key);

  final String Maintitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      Maintitle,
      // textAlign: TextAlign.start,
      style: TextStyle(
        color: Color(0xFF656565),
        fontSize: 19.0,
        letterSpacing: 1.0,
        fontFamily: 'roboto',
      ),
    );
  }
}