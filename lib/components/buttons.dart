import 'package:flutter/material.dart';

class ButtonsApp extends StatelessWidget {
  ButtonsApp({this.color, this.text, this.onPressed});

  final Color color;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(32)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
