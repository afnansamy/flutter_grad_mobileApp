import 'package:flutter/material.dart';
class PopUpDialog extends StatelessWidget {
  const PopUpDialog({
    Key key, this.mainTitle, this.text, this.screenName, this.actionName,
  }) : super(key: key);
  final String mainTitle,text,screenName,actionName;

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(mainTitle),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(" Your Data Has Been Updated,Please Relogin To View Changes"),
          Text(text),
        ],
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(screenName);
            },
            child: Text(actionName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF719fb0),
              ),
            )),
      ],
    );
  }
}
