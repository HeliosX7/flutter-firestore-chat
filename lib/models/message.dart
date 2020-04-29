import 'package:chat/utilities/constants.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String user, text;
  final bool mine;
  final timestamp;
  Message({Key key, this.user, this.text, this.mine, this.timestamp})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment:
            mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            user,
            style: TextStyle(
              color: mine ? Colors.black : royalBlue,
              fontSize: 13,
              fontFamily: 'Montserrat',
            ),
          ),
          Material(
            color: mine ? royalBlue : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            elevation: 5.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: mine ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
