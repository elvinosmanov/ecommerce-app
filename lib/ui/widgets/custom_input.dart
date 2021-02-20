import 'package:ecommmerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final bool isPasswordField;
  final TextInputAction textInputAction;
  const CustomInput(
      {Key key,
      this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.isPasswordField = false,
      this.textInputAction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0), color: Color(0xFFF2F2F2)),
      child: TextField(
        textInputAction: textInputAction,
        obscureText: isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
