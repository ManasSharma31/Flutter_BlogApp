import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:url/url.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UploadPhoto extends StatefulWidget {
  UploadPhoto(this.sample);
  final File sample;
  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  String description;
  String url;
  final _firestore = Firestore.instance;

  void upload() async {
    final StorageReference postFolder = FirebaseStorage.instance
        .ref()
        .child("Images"); //the folder where are uploading the images.
    var timeKey = DateTime
        .now(); //here time is wordking as a key if two people the same pic pic with same caption thn it will not override it.
    final StorageUploadTask uploadTask =
        postFolder.child(timeKey.toString() + ".jpg").putFile(widget.sample);
    var imageUrl = await (await uploadTask.onComplete)
        .ref
        .getDownloadURL(); //this method helps to get the url of the uploaded utem so we can use it in database.
    url = imageUrl.toString();
    saveToDatabase(url);
  }

  void saveToDatabase(String url) {
    //DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    var dbKey = DateTime.now();
    var formatDate = DateFormat('MMM d,yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');
    String date = formatDate.format(dbKey);
    String time = formatTime.format(dbKey);

    _firestore.collection('posts').add(
        {'image': url, 'description': description, 'date': date, 'time': time});

    //databaseReference.child("PostDb").push().set(
    //PostDb is the name of the folder data is the decrpition of the image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: FaIcon(
            FontAwesomeIcons.backward,
          ),
        ),
        title: Text("New Post"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.file(widget.sample, height: 500, width: 500),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(
                  fontSize: 20.0,
                ),
                onChanged: (value) {
                  description = value;
                },
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    hintText: "Write a caption ..",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 3.0))),
              ),
              RaisedButton(
                onPressed: () {
                  upload();
                  Navigator.pop(context);
                },
                child: Text(
                  "Post",
                  style: TextStyle(fontSize: 15),
                ),
                textColor: Colors.white,
                color: Colors.blueAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
