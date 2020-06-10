import 'package:flutter/material.dart';

class Alert {
  alertBox(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            titleTextStyle: TextStyle(fontSize: 30, color: Colors.blueAccent),
            content: Text(
              description,
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  return Navigator.pop(context);
                },
                color: Colors.red,
                child: Text("Ok"),
              )
            ],
          );
        });
  }
}
