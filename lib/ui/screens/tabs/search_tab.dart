import 'package:ecommmerce_app/ui/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomActionBar(
          title: "Search Products",
        ),
        Container(
          child: Center(child: Text('Search Tab')),
        ),
      ],
    );
  }
}
