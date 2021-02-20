import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final selectedTab;
  final void Function(int) tabClicked;

  const BottomTabs({Key key, this.selectedTab, this.tabClicked})
      : super(key: key);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          // borderRadius:
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CustomBottomTabBtn(
            imageAsset: 'assets/images/tab_home.png',
            isSelected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabClicked(0);
            },
          ),
          CustomBottomTabBtn(
            imageAsset: 'assets/images/tab_search.png',
            isSelected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabClicked(1);
            },
          ),
          CustomBottomTabBtn(
            imageAsset: 'assets/images/tab_saved.png',
            isSelected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabClicked(2);
            },
          ),
          CustomBottomTabBtn(
            imageAsset: 'assets/images/tab_logout.png',
            isSelected: _selectedTab == 3 ? true : false,
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class CustomBottomTabBtn extends StatelessWidget {
  final String imageAsset;
  final isSelected;
  final Function onPressed;

  const CustomBottomTabBtn(
      {Key key, this.imageAsset, this.isSelected = false, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: isSelected
                      ? Theme.of(context).accentColor
                      : Colors.transparent,
                  width: 2.0)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 28.0,
          horizontal: 24.0,
        ),
        child: Image(
          width: 22.0,
          height: 22.0,
          color: isSelected ? Theme.of(context).accentColor : Colors.black,
          image: AssetImage(imageAsset ?? 'assets/images/tab_home.png'),
        ),
      ),
    );
  }
}
