import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    Key key,
    @required this.size, this.text, this.SubText,
  }) : super(key: key);
  final String text;
  final String SubText;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.4,
      height: size.width * 0.4,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(0xFF719fb0).withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              //leading: Icon(Icons.album, size: 50),
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'roboto',
                  ),
                ),
              ),

              subtitle: Text(
                SubText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14.0,
                  fontFamily: 'roboto',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
