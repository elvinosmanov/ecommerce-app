import 'package:ecommmerce_app/constants.dart';
import 'package:ecommmerce_app/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot: snapshot);
        } else if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ErrorWidget(snapshot: snapshot);
              }
              if (snapshot.connectionState == ConnectionState.active) {
                User _user = snapshot.data;

                if (_user == null) {
                  return LoginPage();
                } else {
                  return HomePage();
                }
              }

              return LoadingWidget();
            },
          );
        }
        return LoadingWidget();
      },
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;
  const ErrorWidget({Key key, @required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error: ${snapshot.error}'),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
              Text('Initialization app', style: Constants.regularHeading),
            ],
          ),
        ),
      ),
    );
  }
}
