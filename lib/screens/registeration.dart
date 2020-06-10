import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:myb_flutter_app/constants/inputfields.dart';
import 'package:myb_flutter_app/components/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myb_flutter_app/components/alert.dart';

class Registeration extends StatefulWidget {
  @override
  _RegisterationState createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  final _auth = FirebaseAuth.instance;
  bool isspinning = false;
  Alert _alert = Alert();
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isspinning,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              Text(
                "Sign Up Here .!",
                style: TextStyle(fontSize: 50, color: Colors.blueAccent),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                style: TextStyle(fontSize: 20),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration:
                    kInputDecoration.copyWith(hintText: "Email Here..."),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
                obscureText: true,
                decoration:
                    kInputDecoration.copyWith(hintText: "Password Here...."),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonsApp(
                  color: Colors.blueAccent,
                  text: "Submit",
                  onPressed: () async {
                    setState(() {
                      isspinning = true;
                    });
                    try {
                      final newuser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newuser != null) {
                        _alert.alertBox(context, "Successful",
                            "Congratulations your account have been successfully created");
                        Navigator.pushNamed(context, '/blog');
                      }
                      setState(() {
                        isspinning = false;
                      });
                    } catch (e) {
                      _alert.alertBox(context, "Error", e.toString());
                      setState(() {
                        isspinning = false;
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
