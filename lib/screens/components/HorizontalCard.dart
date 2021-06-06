import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  const HorizontalCard({
    Key key,
    @required this.size,
    @required this.Title,
    @required this.type,
    @required this.time, this.icon,
  }) : super(key: key);

  final Size size;
  final String Title;
  final String type;
  final String time;
   final Icon icon;

  @override
  Widget build(BuildContext context) {

    return Container(

      width: size.width * 0.9,
      height: size.height * 0.15,
      child: Card(

        elevation: 5,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          //  SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(

                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Icon(icon.icon,
                        color: Color(0xFFD1D1D1),
                        size: 35.0,
                      )),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:<Widget> [
                        Text(Title,
                          style: TextStyle(
                            color: Color(0xFF414141),
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                            fontFamily: 'roboto',
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(type,
                          style: TextStyle(
                            color: Color(0xFF5E5E5E),
                            fontSize: 14.0,
                            fontFamily: 'roboto',
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(time,
                          style: TextStyle(
                            color: Color(0xFF5E5E5E),
                            fontSize: 14.0,
                            fontFamily: 'roboto',
                          ),
                        ),

                      ],

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}