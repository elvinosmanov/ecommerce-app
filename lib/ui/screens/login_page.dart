import 'package:ecommmerce_app/ui/screens/register_page.dart';
import 'package:ecommmerce_app/ui/widgets/custom_button.dart';
import 'package:ecommmerce_app/ui/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _showAlertDialog(String error) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close Dialog'),
              ),
            ],
          );
        });
  }

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  void _loginForm() async {
    setState(() {
      _loginFormLoading = true;
    });
    String _result = await _loginAccount();
    if (_result != null) {
      _showAlertDialog(_result);
    }
    setState(() {
      _loginFormLoading = false;
    });
  }

  bool _loginFormLoading = false;
  String _loginEmail = '';
  String _loginPassword = '';
  FocusNode _loginFocusNode;
  @override
  void initState() {
    _loginFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _loginFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 24.0),
              child: Text(
                'Welcome User,\nLogin to your Account',
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            Column(
              children: <Widget>[
                CustomInput(
                  hintText: 'Email...',
                  textInputAction: TextInputAction.next,
                  onSubmitted: (value) {
                    _loginFocusNode.requestFocus();
                  },
                  onChanged: (value) {
                    _loginEmail = value;
                  },
                ),
                CustomInput(
                  hintText: 'Password...',
                  focusNode: _loginFocusNode,
                  isPasswordField: true,
                  onChanged: (value) {
                    _loginPassword = value;
                  },
                  onSubmitted: (value) {
                    _loginForm();
                  },
                ),
                CustomButton(
                  text: 'Login',
                  isLoading: _loginFormLoading,
                  outlineBtn: false,
                  onPressed: () {
                    _loginForm();
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CustomButton(
                text: 'Create New Account',
                onPressed: () {
                  return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
