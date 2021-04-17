

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_page/signup.dart';
import 'package:signin_page/successful.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _email = new TextEditingController();

  TextEditingController _password = new TextEditingController();

  bool isloading = false;

  Future<void> signin(BuildContext context) async{

    setState(() {
      isloading=true;
    });
    try{
      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text, password: _password.text);
      // Navigator.pushNamedAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> Successful()) ,(Route<dynamic> route) => false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => Successful()),
              (Route<dynamic> route) => false);
    }catch(e){
      print(e);
    }
    print("Sign in successfully");

    setState(() {
      isloading=false;
    });
    // MainScreen123();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Log In"),
      // ),
        body: isloading ? Center(child: CircularProgressIndicator(
          // strokeWidth: 10,
        )) : SingleChildScrollView(child: Container(
            // color: Colors.redAccent,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Container(
                  height: 60,
                  margin: EdgeInsets.only(left: 30 , right: 30),
                  padding: EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(30)

                  ),
                  child: TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: "Email",
                      icon: Icon(Icons.email),
                      labelText: "Email",

                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 60,
                  margin: EdgeInsets.only(left: 30 , right: 30),
                  padding: EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(30)

                  ),
                  child: TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter password Here",
                      icon: Icon(Icons.lock),
                      labelText: "Enter Password",

                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 40,
                  width: 120,

                  child: FlatButton(
                    child: Text("Log In"),
                    onPressed: (){
                      signin(context);
                    },
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),

                SizedBox(height: 70),

                Container(
                  height: 40,
                  width: 120,

                  child: FlatButton(
                    child: Text("Sign Up"),
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignUp()));

                    },
                  ),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(30)
                  ),
                )




              ],
            ),
          ),
        ),
    );
  }
}

