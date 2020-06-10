import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:myb_flutter_app/constants/inputfields.dart';
import 'package:myb_flutter_app/components/buttons.dart';
import 'package:myb_flutter_app/components/alert.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:myb_flutter_app/modules/googlesignin.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  //final _message = TextEditingController();
  Alert _alert = Alert();
  String email, password;
  bool isspinning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xffB7EDFC),
      body: ModalProgressHUD(
        inAsyncCall: isspinning,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'images/pp.jpg',
                  ))),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          height: 100,
                          child: Image.asset('images/logo.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Share YourSelf!",
                      style: TextStyle(fontSize: 50, color: Colors.blueAccent),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  style: TextStyle(fontSize: 25, color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration:
                      kInputDecoration.copyWith(hintText: "Email Here......"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    style: TextStyle(fontSize: 25, color: Colors.black),
                    autocorrect: false,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: kInputDecoration.copyWith(
                      hintText: "Password Here......",
                    )),
                SizedBox(
                  height: 20,
                ),
                ButtonsApp(
                    color: Colors.blueAccent,
                    text: 'Login In',
                    onPressed: () async {
                      setState(() {
                        isspinning = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          setState(() {
                            isspinning = false;
                          });
                          Navigator.pushNamed(context, '/blog');
                        }
                      } catch (e) {
                        _alert.alertBox(context, "Error", e.toString());
                        setState(() {
                          isspinning = false;
                        });
                      }
                    }),
                SizedBox(height: 40),
                Text(
                  "Don't have a account? Sign Up for free <3",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.amber,
                      fontWeight: FontWeight.w900),
                ),
                ButtonsApp(
                  color: Colors.blueAccent,
                  text: "Sign Up",
                  onPressed: () {
                    Navigator.pushNamed(context, '/registeration');
                  },
                ),
                ButtonsApp(
                    color: Colors.blueAccent,
                    text: "Sign Up with Google",
                    onPressed: () async {
//                      try {
//                        var user = signInWithGoogle();
//                        if (user != null)
//                          Navigator.pushNamed(context, '/registeration');
//                        print(user);
//                      } catch (e) {
//                        print(e.toString());
//                      }
                      setState(() {
                        isspinning = true;
                      });
                      try {
                        GoogleSignIn googleSignIn = GoogleSignIn();
                        GoogleSignInAccount account =
                            await googleSignIn.signIn();
                        if (account != null) {
                          AuthResult res = await _auth.signInWithCredential(
                              GoogleAuthProvider.getCredential(
                                  idToken:
                                      (await account.authentication).idToken,
                                  accessToken: (await account.authentication)
                                      .accessToken));
                          if (res.user != null) {
                            setState(() {
                              isspinning = false;
                            });
                            Navigator.pushNamed(context, '/blog');
                          }
                        }
                      } catch (e) {
                        setState(() {
                          isspinning = false;
                        });
                        _alert.alertBox(context, "Error", e.toString());
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
