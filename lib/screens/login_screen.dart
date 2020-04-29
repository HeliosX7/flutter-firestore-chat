import 'package:chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:chat/models/auth.dart';
import 'package:chat/models/dialogbox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum FormType { login, register }

class LoginScreen extends StatefulWidget {
  final AuthImplementation auth;
  final VoidCallback signedIn;
  LoginScreen({
    this.auth,
    this.signedIn,
  });
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DialogBox dialogBox = DialogBox();

  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;

  String _email = "";
  String _password = "";

  void submitForm() async {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      try {
        if (_formType == FormType.login) {
          String authResult = await widget.auth.signIn(_email, _password);
          dialogBox.information(
              context, "Congratulations", "You are logged in successfully");
          print(authResult);
        } else {
          String authResult = await widget.auth.signUp(_email, _password);
          dialogBox.information(context, "Congratulations",
              "Your account has been created successfully");
          print(authResult);
        }
        widget.signedIn();
      } catch (e) {
        dialogBox.information(context, "Error", e.toString());
      }
    }
  }

  void switchForm(FormType formType) {
    formKey.currentState.reset();
    setState(() {
      _formType = formType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: royalBlue,
      child: Container(
        margin: EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.fireAlt,
                size: 120,
                color: buff,
              ),
              Text(
                "Fire Chat.",
                style: TextStyle(
                    fontFamily: "Spartan",
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 15.0),
                          blurRadius: 15.0),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, -10.0),
                          blurRadius: 10.0),
                    ]),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                  child: Column(
                    children: screenInputs(),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: screenButtons(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> screenInputs() {
    return [
      TextFormField(
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Spartan',
            fontSize: 20,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontFamily: 'Montserrat',
            fontSize: 14,
          ),
        ),
        validator: (value) {
          return value.isEmpty ? 'Email is required' : null;
        },
        onSaved: (value) {
          return _email = value;
        },
      ),
      SizedBox(
        height: 10,
      ),
      TextFormField(
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Spartan',
            fontSize: 20,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontFamily: 'Montserrat',
            fontSize: 14,
          ),
        ),
        obscureText: true,
        validator: (value) {
          return value.isEmpty ? 'Password is required' : null;
        },
        onSaved: (value) {
          return _password = value;
        },
      ),
    ];
  }

  List<Widget> screenButtons() {
    if (_formType == FormType.login) {
      return [
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: submitForm,
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: cornFlowerBlue,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontFamily: 'Spartan',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
              ),
            ),
          ),
        ),
        FlatButton(
          child: Text(
            "Don't have an account? Register",
            style: TextStyle(
                color: antiFlashWhite, fontFamily: 'Poppins', fontSize: 12),
          ),
          onPressed: () {
            switchForm(FormType.register);
          },
        )
      ];
    } else {
      return [
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: submitForm,
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: cornFlowerBlue,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "REGISTER",
                  style: TextStyle(
                      fontFamily: 'Spartan',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
              ),
            ),
          ),
        ),
        FlatButton(
          child: Text(
            "Don't have an account? Register",
            style: TextStyle(
                color: antiFlashWhite, fontFamily: 'Poppins', fontSize: 12),
          ),
          onPressed: () {
            switchForm(FormType.login);
          },
        )
      ];
    }
  }
}
