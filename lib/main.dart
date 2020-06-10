import 'package:flutter/material.dart';
import 'package:myb_flutter_app/screens/home.dart';
import 'package:myb_flutter_app/screens/registeration.dart';
import 'package:myb_flutter_app/screens/blog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Abel'),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/registeration': (context) => Registeration(),
        '/blog': (context) => Blog(),
      },
    );
  }
}
