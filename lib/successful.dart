import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:signin_page/Upload.dart';
import 'package:signin_page/notes_sample/notes.dart';
import 'package:signin_page/signup.dart';
class Successful extends StatefulWidget {

  @override
  _SuccessfulState createState() => _SuccessfulState();
}

class _SuccessfulState extends State<Successful> {


  User firebaseUser;
  getData() {
    firebaseUser = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState

    getData();
    super.initState();

    // FirebaseAuth.instance.authStateChanges().listen((firebaseuser) {
    //   if(firebaseuser == null){
    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: (_) => SignUp()),
    //             (Route<dynamic> route) => false);
    //   }else{
    //
    //   }
    // });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen "),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app , color: Colors.black,),
            onPressed: () async {
              FirebaseAuth.instance.signOut().then((onValue) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
              });
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream:  FirebaseFirestore.instance.collection("Statuses").snapshots(),
        builder: (context , AsyncSnapshot<QuerySnapshot> snapshot){
          if( !snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          if( snapshot.data.docs.length == 0){
            return Center(child: Text("No Data"));
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context , index){
                String uid = snapshot.data.docs[index].data()['docid'];
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    focusColor: Colors.redAccent,
                    trailing: Icon(Icons.delete ) ,
                    onTap: (){
                      FirebaseFirestore.instance.collection("Statuses").doc(uid).delete().then((value){
                        Fluttertoast.showToast(msg: "Successful");
                      });
                      // Fluttertoast.showToast(msg: uid);
                      // FirebaseFirestore.instance.collection("Statuses").doc().delete();
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => NoteSample()));
                  },
                    leading: Image.network(snapshot.data.docs[index].data()['imageUrl']),
                    title: Text(snapshot.data.docs[index].data()['title']),
                    subtitle: Text(snapshot.data.docs[index].data()['message']),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UpLoad()));
          },
        child: Icon(Icons.add, color: Colors.black,),
      ),
    );
  }
}



//<!-- The core Firebase JS SDK is always required and must be listed first -->
// <script src="/__/firebase/8.3.3/firebase-app.js"></script>
//
//TODO: Add SDKs for Firebase products that you want to use
//      https://firebase.google.com/docs/web/setup#available-libraries -->
// <script src="/__/firebase/8.3.3/firebase-analytics.js"></script>
//
// <!-- Initialize Firebase -->
// <script src="/__/firebase/init.js"></script>