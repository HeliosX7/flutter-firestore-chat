import 'package:chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DialogBox {
  information(BuildContext context, String title, String desc) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: cornFlowerBlue,
            title: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Spartan',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    desc,
                    style: TextStyle(
                      color: antiFlashWhite,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  return Navigator.pop(context);
                },
                child: FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.white,
                ),
              ),
            ],
          );
        });
  }
}
