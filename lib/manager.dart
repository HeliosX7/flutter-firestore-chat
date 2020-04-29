import 'package:chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:chat/models/auth.dart';

enum authStatus { signedout, signedIn }

class Manager extends StatefulWidget {
  final AuthImplementation auth;

  Manager({
    this.auth,
  });

  @override
  _ManagerState createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  authStatus _authStatus = authStatus.signedout;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUserId().then((firebaseUserId) {
      setState(() {
        _authStatus =
            firebaseUserId == null ? authStatus.signedout : authStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      _authStatus = authStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = authStatus.signedout;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case authStatus.signedout:
        return LoginScreen(
          auth: widget.auth,
          signedIn: _signedIn,
        );
      case authStatus.signedIn:
        return ChatScreen(
          auth: widget.auth,
          signedOut: _signedOut,
        );
    }

    return null;
  }
}
