import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signin_page/firedata_retrive/firedata_retrive.dart';
import 'package:signin_page/models/status_mode.dart';
import 'notes_sample/notes.dart';

class UpLoad extends StatefulWidget {
  UpLoad({this.app});
  final FirebaseApp app;
  @override
  _UpLoadState createState() => _UpLoadState();
}

class _UpLoadState extends State<UpLoad> {

  final firedata = FirebaseDatabase.instance;
  // final myController = TextEditingController();
  // final name = "Name";


  TextEditingController _title = new TextEditingController();
  TextEditingController _message = new TextEditingController();

  File _imageFile = null;
  bool isloading = false;

  String name= 'Name';
  String message= ' message';

  int _counter = 0;

  CollectionReference ref_collection = FirebaseFirestore.instance.collection("Statuses");
  
  
  Future pickimage() async {
    var file = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = File(file.path);
    });
  }

  Future<dynamic> uploadStatus() async {

    setState(() {
      isloading=true;
    });
    // var imageUpload = await uploadImage();
    // StatusModel statusmodel = new StatusModel();
    //
    // statusmodel.imageUrl = imageUpload.toString();
    // statusmodel.title = _title.text;
    // statusmodel.message = _message.text;




    //    -----   new   -----

    StatusModel statusmodel = new StatusModel();
    if(_counter == 0 ){
      print("No");
      Fluttertoast.showToast(msg: "Please Select One Image");
      setState(() {
        isloading=false;
      });
    }else{
      var imageUpload = await uploadImage();

      statusmodel.imageUrl = imageUpload.toString();
      statusmodel.title = _title.text;
      statusmodel.message = _message.text;
      print(_counter.toInt());
      print("Yes");
      String docId =  FirebaseFirestore.instance.collection("Statuses").doc().id;
      statusmodel.docid = docId.toString();
      await FirebaseFirestore.instance.collection("Statuses").doc(docId).set(statusmodel.toMap());

      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Data sucessful");

    }



    //   -----   1   -----
    // var docId = await FirebaseFirestore.instance.collection("Statuses").doc().get();
    // var docId = await FirebaseFirestore.instance.collection("Statuses").doc().get();
    // statusmodel.docid = docId.toString();


    //    -----   2   -----
    // String docId =  FirebaseFirestore.instance.collection("Statuses").doc().id;
    // statusmodel.docid = docId.toString();
    //  await FirebaseFirestore.instance.collection("Statuses").doc(docId).set(statusmodel.toMap());

    //    -----   3   -----
    // await FirebaseFirestore.instance.collection("Name").doc(myDocId).get().then((value) {
    //   documentSnapshot=value;


    //   -----   firebase Dtatabase Upload   -----
    String email_user= FirebaseAuth.instance.currentUser.uid.toString();
    FirebaseDatabase.instance.reference().child(email_user).push().set(statusmodel.toMap());



    // print(docId.toString());
    // Fluttertoast.showToast(msg: ""+ docId);
    // Navigator.pop(context);
    // Fluttertoast.showToast(msg: "Data sucessful");


    // var doc_ref = await FirebaseFirestore.instance.collection("board").doc(doc_id).collection("Dates").getDocuments();
    // doc_ref.documents.forEach((result) {
    //   print(result.documentID);
    // });
    setState(() {
      isloading=false;
    });
    // var doc_id2 = docSnap.reference.documentID;
    // DocumentReference doc_ref=FirebaseFirestore.instance.collection("board").document(doc_id).collection("Dates").document();

    // String docId = FirebaseFirestore.instance.collection("Statuses");
  }

  Future<dynamic> uploadImage() async {

    FirebaseStorage storage = FirebaseStorage.instance;

    Reference reference = storage.ref().child("Statuses");
    UploadTask uploadTask = reference
        .child("stat_" + DateTime.now().toIso8601String())
        .putFile(_imageFile);
    //  -----   1   -----
    // uploadTask.then((res){
    //   var downloadURL = res.ref.getDownloadURL();
    //   return downloadURL;
    // });
    //  -----   2   -----
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    print(imageUrl.toString());

    return imageUrl;

    // Fluttertoast.showToast(msg: "Data Upload");


    //FirebaseStorage storage = FirebaseStorage.instance;
    // Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    // UploadTask uploadTask = ref.putFile(_image1);
    // uploadTask.then((res) {
    //    res.ref.getDownloadURL();
    // });
  } // SingleChildScrollView

  @override
  Widget build(BuildContext context) {
    final ref123 = firedata;
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Status"),
        leading: Icon(Icons.upload_file ),
        actions: [
          FlatButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteSample()));
            },
            child: Text("Notes",
              style: TextStyle(
              color: Colors.white,
              fontSize: 15
            ),),
            // Icon(Icons.ac_unit ),
          )
        ],
      ),
      body: isloading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Column(
          //isloading ? Center(child: CircularProgressIndicator(),) :
          children: [
            // _imageFile ==null ? Text("No Image Choosen"): Image.file(_imageFile),
            Center(
              child: Container(
                // color: Colors.redAccent,
                height: 150,
                width: double.infinity,
                // color: Colors.redAccent,
                child: ClipRect(
                  child: _imageFile == null
                      ? Center(child: Text("No Image choosen"))
                      : Image.file(_imageFile),
                ),
              ),
            ),
            SizedBox(height: 20),

            RaisedButton(
              onPressed: () {
                pickimage();
                _counter = 1;
              },
              child: Text("Choose Image from gallery"),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: _title,
                decoration: InputDecoration(
                    hintText: "Enter Title",
                    contentPadding: EdgeInsets.only(left: 20),
                    // fillColor: Colors.grey,
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                minLines: 3,
                maxLines: 10,
                controller: _message,
                decoration: InputDecoration(
                    hintText: "Enter Message",
                    // labelText: "Message",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("Upload"),
              onPressed: (){
                uploadStatus();
              },
            ),
            RaisedButton(
              child: Text("Firebase Retrive"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> FireDataRetrive()));
                // uploadStatus();
              },
            ),
          ],
        ),
            ),
    );
  }
}
