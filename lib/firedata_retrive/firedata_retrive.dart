import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:signin_page/models/realdatabase.dart';

class FireDataRetrive extends StatefulWidget {
  @override
  _FireDataRetriveState createState() => _FireDataRetriveState();
}

class _FireDataRetriveState extends State<FireDataRetrive> {

  DatabaseReference _ref;

  //  new
  List<RealData> datalist=[];

  @override
  void initState() {
    // TODO: implement initState
    // final String email_user= FirebaseAuth.instance.currentUser.uid.toString();
    // final FirebaseDatabase database = FirebaseDatabase();
    // _reference = database.reference().child(email_user);
    // _ref = FirebaseDatabase.instance.reference().child(email_user);

    super.initState();

    //    new
    final String email_user= FirebaseAuth.instance.currentUser.uid.toString();
    DatabaseReference referenceData = FirebaseDatabase.instance.reference().child(email_user);
    _ref = FirebaseDatabase.instance.reference().child(email_user);
    referenceData.once().then((DataSnapshot dataSnapshot) {
      datalist.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for( var key in keys){
        RealData data = new RealData(
          values [key]["title"],
          values [key]['message'],
          values [key]['docid'],
          values [key]['imageUrl']
        );
        datalist.add(data);
      }
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    String email_user= FirebaseAuth.instance.currentUser.uid.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Firedata Retrive"),
      ),
      body: datalist.length ==0 ? Center(child: Text("No Data Avaliable")) : ListView.builder(
        itemCount: datalist.length,
        itemBuilder: ( _ , index){
          if( datalist.length== 0  ){
            return Center(child: Text("No avav"));
          }
          return CardUI(datalist[index].title , datalist[index].message , datalist[index].docid  , datalist[index].imageUrl , datalist[index]) ;
        },
      ),


    );
  }

  Widget CardUI(String title, String message, String docid , String imageUrl, RealData data) {
    return Card(
      margin: EdgeInsets.all(5),
      color: Colors.blueAccent,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(2),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // SizedBox(width: 10,),
              GestureDetector(
                  onTap: (){
                    // _ref.child(data).remove();
                    // _ref.child().remove();
                  },
                  child: Image.network(imageUrl , height: 100 , width: 100, fit: BoxFit.cover,)
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      // padding: EdgeInsets.only(left: 5),
                      child: Text(title , style: TextStyle( fontSize: 23 , color: Colors.black) )
                  ),
                  SizedBox(height: 10,),
                  Container(
                      color: Colors.redAccent,
                      padding: EdgeInsets.only(right: 5 , left: 5),
                      child: Text(message, style: TextStyle(fontSize: 10 , color: Colors.black))
                  )
                ],
              ),
              SizedBox(width: 10,)
              // Text(title , style: TextStyle( fontSize: 23 , color: Colors.black),),
              // SizedBox(width: 10,),
              // Text(message, style: TextStyle(fontSize: 10 , color: Colors.black),)
            ],
          ),
        ),
      ),
    );
  }
}

// Flexible(
//         child: new FirebaseAnimatedList(
//             shrinkWrap: true,
//             query: _reference,
//             itemBuilder: (BuildContext context, DataSnapshot snapshot , Animation<double> animation , int index){
//               return new ListTile(
//                 trailing:  IconButton(icon: Icon(Icons.delete),onPressed: (){
//
//                 },),
//                 title:  new Text(snapshot.key.value['title']),
//
//               );
//             }),
//       ),