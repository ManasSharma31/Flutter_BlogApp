import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myb_flutter_app/constants/inputfields.dart';
import 'package:myb_flutter_app/screens/uploadphoto.dart';
import 'package:myb_flutter_app/modules/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  final _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser loggedInuser;
  File _image;
  //String email;
  final _firestore = Firestore.instance;

  List<Post> posts = [];

  @override
  void initState() {
    getcurrentuser();
    // getGoogleuser();
    super.initState();
//    DatabaseReference databaseReference =
//        FirebaseDatabase.instance.reference().child('PostDb');
//
//    databaseReference.once().then((DataSnapshot snap) {
//      var keys = snap.value.keys;
//      var data = snap.value;
//
//      for (var individualkey in keys) {
//        Post post = new Post(
//            data[individualkey]['image'],
//            data[individualkey]['description'],
//            data[individualkey]['date'],
//            data[individualkey]['time']);
//        posts.add(post);
//      }
    //   });
  }

  void getcurrentuser() async {
    final user = await _auth.currentUser();
    if (user != null) {
      loggedInuser = user;
      print(loggedInuser.email);
    }
  }

//  void getGoogleuser() async {
//    final user = await _googleSignIn.currentUser;
//    if (user != null) email = user.email;
//  }

  opencamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  opengallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: kBackColour,

//          leading: IconButton(
//            icon: FaIcon(FontAwesomeIcons.camera),
//            onPressed: () {
//              opencamera();
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) {
//                    return UploadPhoto(_image);
//                  },
//                ),
//              );
//            },
//          ),
          title: Text(
            "Share Yourself",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: FaIcon(FontAwesomeIcons.signOutAlt),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
//              UserAccountsDrawerHeader(
//                  arrowColor: Colors.black,
//                  currentAccountPicture: CircleAvatar(
//                    backgroundImage: AssetImage('images/download.jpg'),
//                    backgroundColor: Colors.black,
//                  ),
//                  accountName: Text(
//                    "Manas",
//                    style: TextStyle(fontSize: 20, color: Colors.black),
//                  ),
//                  accountEmail: Text(
//                    _googleSignIn.currentUser.email,
//                    style: TextStyle(fontSize: 20, color: Colors.black),
//                  )),
              ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.home,
                  ),
                  title: Text("Home",
                      style: TextStyle(fontSize: 20, color: Colors.black)))
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kBackColour,
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
              title: Text(
                "Home",
                style: TextStyle(fontSize: 17),
              ),
              icon: IconButton(
                iconSize: 25,
                color: Colors.black,
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
            ),
            BottomNavigationBarItem(
              title: Text(
                "Gallery",
                style: TextStyle(fontSize: 17),
              ),
              icon: IconButton(
                iconSize: 25,
                color: Colors.black,
                icon: Icon(Icons.add),
                onPressed: () {
                  opengallery();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UploadPhoto(_image);
                      },
                    ),
                  );
                },
              ),
            ),
            BottomNavigationBarItem(
              title: Text(
                "Gallery",
                style: TextStyle(fontSize: 17),
              ),
              icon: IconButton(
                iconSize: 25,
                color: Colors.black,
                icon: Icon(Icons.add),
                onPressed: () {
                  opengallery();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UploadPhoto(_image);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('posts').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.black),
                    );
                  }
                  final message = snapshot.data
                      .documents; //so that the messages enter the last must apper first
                  List<PostUI> posts = [];
                  for (var messages in message) {
                    final image = messages.data['image'];
                    final description = messages.data['description'];
                    final date = messages.data["date"];
                    final time = messages.data['time'];

                    final singlepost = PostUI(image, description, date, time);
                    posts.add(singlepost);
                    posts.sort((a, b) => b.time.compareTo(a.time));
                  }
                  return Expanded(
                      child: ListView(reverse: false, children: posts));
                },
              )
            ])));
  }
}

class PostUI extends StatelessWidget {
  PostUI(this.image, this.description, this.date, this.time);

  final String image, description, date, time;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  date,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  time,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Image.network(
              image,
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(description,
                    //textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
