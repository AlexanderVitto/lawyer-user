import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Color inputBorderColor;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final Function onEditingComplete;
  final ValueChanged<String> onSubmitted;
  final bool obsecureText;
  final Color fillColor;
  final String labelText;
  final double labelFontSize;
  final Color labelColor;
  final String hintText;
  final double hintFontSize;
  final Color hintColor;
  final String helperText;
  final double helperFontSize;
  final Color helperColor;
  final Color borderColor;
  final Widget suffixIcon;

  const CustomTextField(
      {Key key,
      this.inputBorderColor = Colors.white,
      this.controller,
      this.keyboardType = TextInputType.emailAddress,
      this.onChanged,
      this.onEditingComplete,
      this.onSubmitted,
      this.obsecureText = false,
      this.fillColor = Colors.white,
      this.labelText,
      this.labelFontSize = 14,
      this.labelColor = Colors.white,
      this.hintText = '',
      this.hintFontSize = 14,
      this.hintColor = Colors.grey,
      this.helperText = '',
      this.helperFontSize = 12,
      this.helperColor = Colors.white,
      this.borderColor = Colors.white,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
        primaryColor: inputBorderColor,
        primaryColorDark: Colors.blue,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        obscureText: obsecureText,
        decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            labelText: labelText,
            labelStyle: TextStyle(
                color: labelColor,
                fontSize: labelFontSize,
                fontWeight: FontWeight.w600),
            hintText: hintText,
            hintStyle: TextStyle(
                color: hintColor,
                fontSize: hintFontSize,
                fontWeight: FontWeight.w600),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            helperText: helperText,
            helperStyle: TextStyle(
                color: helperColor,
                fontSize: helperFontSize,
                fontWeight: FontWeight.w600),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1.5, color: borderColor),
            ),
            suffixIcon: suffixIcon),
      ),
    );
  }
}
