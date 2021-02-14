import 'package:ecommmerce_app/ui/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomActionBar(
          title: 'Saved Products',
        ),
        Container(
          child: Center(child: Text('Saved Tab')),
        ),
      ],
    );
  }
}
