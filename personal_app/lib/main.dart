import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Abel"),
        home: SafeArea(
            child: Scaffold(
                backgroundColor: Color(0xff43d8c9),
                body: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xff4cbbb9),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32))),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 15,
                            bottom: 20,
                            child: Container(
//                        margin: EdgeInsets.all(20),
                              height: 250,
                              width: 140,
                              decoration: BoxDecoration(
//                            boxShadow: [
//                              BoxShadow(
//                                color: Color(0x30bc658d),
//                                offset: Offset(5.0, 5.0),
//                                blurRadius: 5.0,
//                                spreadRadius: 1.0,
//                              ),
//                              BoxShadow(
//                                color: Color(0xbc658d),
//                                offset: Offset(-5.0, -5.0),
//                                blurRadius: 5.0,
//                                spreadRadius: 1.0,
//                              )
//                            ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      image: AssetImage('images/my.jpeg'),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          Positioned(
                            right: 60,
                            bottom: 150,
                            child: Text(
                              "Manas Sharma",
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Satisfy",
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            right: 40,
                            bottom: 120,
                            child: Text(
                              "- a Full Stack developer",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Satisfy",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          Positioned(
                            right: 50,
                            bottom: 20,
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.mail_outline),
                                ),
                                IconButton(
                                  icon: Icon(Icons.phone_forwarded),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "About",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            ),
                            Text(
                              "I'm Manas Sharma , currently pursuing Btech from KIIT University,Bhubneswar.I have done web development,flutter develpment,and a handful of machine learning.I wamt to become a developer in near future.I have designed around 50 UIs.",
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Address",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 30)),
                                  Container(
                                      width: 300,
                                      child: Text(
                                        "365/3 Mendhi hasan Ka Hata Sadar Bazar Cantt,Lucknow",
                                        style: TextStyle(fontSize: 25),
                                      ))
                                ]),
                          ),
                          Expanded(
                            child: Container(
                              height: 150,
//                        margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      image: AssetImage('images/map.jpg'),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                          child: Center(
                              child: Text(
                        "Made with ❤ by Manas Sharma",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ))),
                    )
                  ]),
                ))));
  }
}
