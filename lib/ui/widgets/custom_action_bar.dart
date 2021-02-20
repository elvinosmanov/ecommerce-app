import 'package:ecommmerce_app/constants.dart';
import 'package:ecommmerce_app/core/navigator/generate_route.dart';
import 'package:ecommmerce_app/core/viewmodels/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomActionBar extends StatefulWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final hasBackground;
  const CustomActionBar({
    Key key,
    this.title,
    this.hasBackArrow = false,
    this.hasTitle = true,
    this.hasBackground = true,
  }) : super(key: key);

  @override
  _CustomActionBarState createState() => _CustomActionBarState();
}

class _CustomActionBarState extends State<CustomActionBar> {
  @override
  Widget build(BuildContext context) {
    final _myProvider = Provider.of<MyProvider>(context);

    return Container(
      decoration: BoxDecoration(
          gradient: widget.hasBackground
              ? LinearGradient(
                  colors: [Colors.white, Colors.white.withOpacity(0)],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1))
              : null),
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 42.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          if (widget.hasTitle)
            Text(
              widget.title ?? 'Action Bar',
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, GenerateRoute.cartPageRoute);
            },
            child: Container(
                width: 42.0,
                height: 42.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _myProvider.cartNum == 0
                      ? Colors.black
                      : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_myProvider.cartNum}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                )),
          ),
        ],
      ),
    );
  }
}
