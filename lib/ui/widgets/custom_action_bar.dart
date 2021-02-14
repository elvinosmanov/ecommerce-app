import 'package:ecommmerce_app/constants.dart';
import 'package:ecommmerce_app/core/services/firebase_services.dart';
import 'package:ecommmerce_app/ui/screens/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
  FirebaseServices _firebaseServices = FirebaseServices();

  int cartNum = 0;

  @override
  Widget build(BuildContext context) {
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CartPage()));
            },
            child: Container(
              width: 42.0,
              height: 42.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    cartNum == 0 ? Colors.black : Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: StreamBuilder(
                stream: _firebaseServices.usersRef
                    .doc(_firebaseServices.getUserId())
                    .collection('Cart')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    List documents = snapshot.data.docs;

                    SchedulerBinding.instance
                        .addPostFrameCallback((_) => setState(() {
                              cartNum = documents.length;
                            }));
                  }

                  return Text(
                    '$cartNum',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
