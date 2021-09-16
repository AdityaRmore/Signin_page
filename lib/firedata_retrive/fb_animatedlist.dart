import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FbAnimatedlist extends StatefulWidget {
  @override
  _FbAnimatedlistState createState() => _FbAnimatedlistState();
}

class _FbAnimatedlistState extends State<FbAnimatedlist> {

  Query _ref;
  DatabaseReference reference =
  FirebaseDatabase.instance.reference().child('Contacts');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String email_user= FirebaseAuth.instance.currentUser.uid.toString();
    _ref = FirebaseDatabase.instance
        .reference()
        .child(email_user);
  }



  Widget _buildcontact({Map contact}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: double.infinity,
      width: 180,
      color: Colors.white,
      child: Card(
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(contact['imageUrl']),
              SizedBox(height: 30,),
              Text(contact['title']),
              Text(contact['message']),
              Text(contact['docid'], style: TextStyle(fontSize: 10),),

            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fb Animated list"),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Text("fhhbbkb"),
            SizedBox(height: 50,),
            Expanded(
              child: FirebaseAnimatedList(
                scrollDirection: Axis.horizontal,
                query: _ref,
                itemBuilder: (BuildContext context , DataSnapshot snapshot , Animation<double> animation, int index){
                  Map contact = snapshot.value;
                  contact['key']= snapshot.key;
                  return _buildcontact(contact : contact);
                },
              ),
            ),
            SizedBox(height: 300,),
            Text('ybdjvbyb'),
            Text('ybdjvbyb'),
            Text('ybdjvbyb'),
            Text('ybdjvbyb'),
            Text('ybdjvbyb'),
            Text('ybdjvbyb'),
          ],
        ),
      ),

    );
  }


}
