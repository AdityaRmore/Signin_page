import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signin_page/notes_sample/editfile.dart';

class NoteSample extends StatelessWidget {

  final ref = FirebaseFirestore.instance.collection("Statuses");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
              itemBuilder: (context , index){
                return CardUI( snapshot.data.docs[index].get('title') , snapshot.data.docs[index].get('message') , snapshot.data.docs[index].get('imageUrl') ,  context , snapshot.data.docs[index]);
              });
        }
      ),
    );
  }

  Widget CardUI(param0, param1, imageurl ,  BuildContext context, QueryDocumentSnapshot doc) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> EditNote(doctoedit: doc)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.lightBlueAccent,
        ),
        margin: EdgeInsets.all(6),
        height: 300,
        // width: 100,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.network(imageurl , height: 100, width: 100,),
              ),
              Text(param0, style: TextStyle(
                  fontSize: 20
              ),),
              Text(param1)
            ],
          ),
        ),
      ),
    );
  }

}