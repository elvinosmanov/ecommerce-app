import 'package:ecommmerce_app/constants.dart';
import 'package:ecommmerce_app/core/viewmodels/CRUDModelOfCart.dart';
import 'package:ecommmerce_app/core/viewmodels/my_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'login_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<CRUDModelOfCart>(context);
    final myProvider = Provider.of<MyProvider>(context);
    if (firstTime) {
      myProvider.changeCartNum();
      firstTime = false;
    }
    return StreamBuilder(
      stream: _provider.userAsStream(),
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
