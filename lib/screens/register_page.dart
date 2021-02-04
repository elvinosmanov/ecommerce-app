import 'package:ecommmerce_app/constants.dart';
import 'package:ecommmerce_app/widgets/custom_button.dart';
import 'package:ecommmerce_app/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  void _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });
    String _result = await _createAccount();
    if (_result != null) {
      _showAlertDialog(_result);
    } else {
      Navigator.pop(context);
    }
    setState(() {
      _registerFormLoading = false;
    });
  }

  bool _registerFormLoading = false;
  String _registerEmail = '';
  String _registerPassword = '';
  FocusNode _registerFocusNode;
  @override
  void initState() {
    _registerFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _registerFocusNode.dispose();
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
                'Create New Account',
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
                    _registerFocusNode.requestFocus();
                  },
                  onChanged: (value) {
                    _registerEmail = value;
                  },
                ),
                CustomInput(
                  hintText: 'Password...',
                  focusNode: _registerFocusNode,
                  isPasswordField: true,
                  onChanged: (value) {
                    _registerPassword = value;
                  },
                  onSubmitted: (value) {
                    _submitForm();
                  },
                ),
                CustomButton(
                  text: 'Create New Account',
                  isLoading: _registerFormLoading,
                  outlineBtn: false,
                  onPressed: () {
                    _submitForm();
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CustomButton(
                text: 'Back to Login',
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
