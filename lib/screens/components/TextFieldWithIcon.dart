import 'package:flutter/material.dart';

class TextFieldWithIcon extends StatelessWidget {
  const TextFieldWithIcon({
    Key key, this.text, this.icon,
  }) : super(key: key);
  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: new InputDecoration(
        prefixIcon:icon,
        hintText: text,
        hintStyle:
        new TextStyle(color: const Color(0xFFACACAC)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Color(0xFF719fb0).withOpacity(0.7)),
        ),
      ),
    );
  }
}
