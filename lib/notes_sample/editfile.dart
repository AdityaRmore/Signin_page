import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {

  DocumentSnapshot doctoedit;
  EditNote({this.doctoedit});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {


  String title_st , mess_st;
  String image_url;

  @override
  void initState() {

    title_st = widget.doctoedit.get('title');
    mess_st = widget.doctoedit.get('message');
    image_url=widget.doctoedit.get('imageUrl');


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 300,
                  width: 300,

                  child: Image.network(image_url)),
              Text(title_st , style: TextStyle(
                fontSize: 30
              ),),
              Text(mess_st)
            ],
          ),
        ),
      ),
    );
  }
}
