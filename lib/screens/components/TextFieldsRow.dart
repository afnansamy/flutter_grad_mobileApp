import 'package:flutter/material.dart';

class TextFieldsRow extends StatelessWidget {
  const TextFieldsRow({
    Key key,
    @required this.size, this.field1, this.field2,
  }) : super(key: key);

  final Size size;
  final String field1;
  final String field2;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        width:size.width*0.4-30 ,
        child: TextField(
          decoration: new InputDecoration(
            hintText: field1,

            hintStyle: new TextStyle(
                color: const Color(0xFFACACAC)
            ),


            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF719fb0).withOpacity(0.7)),
            ),
          ),

        ),
      ),
      Spacer(),
      Container(
        width:size.width*0.4-30,
        child: TextField(
          decoration: new InputDecoration(
            hintText: field2,

            hintStyle: new TextStyle(
                color: const Color(0xFFACACAC)
            ),


            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF719fb0).withOpacity(0.7)),
            ),
          ),

        ),
      ),
    ],);
  }
}