import 'package:ecommmerce_app/widgets/bottom_tabs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: PageView(
          controller: _tabsPageController,
          onPageChanged: (value) {
            setState(() {
              _selectedTab = value;
            });
          },
          children: [
            Container(
              child: Center(child: Text('HomePage')),
            ),
            Container(
              child: Center(child: Text('SearchPage')),
            ),
            Container(
              child: Center(child: Text('SavedPage')),
            ),
          ],
        )),
        Container(
          child: BottomTabs(
            selectedTab: _selectedTab,
            tabClicked: (num) {
              _tabsPageController.animateToPage(num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
          ),
        ),
      ],
    ));
  }
}
