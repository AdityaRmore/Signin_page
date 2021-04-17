import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:signin_page/signin.dart';
import 'main.dart';

class SignUp extends StatefulWidget {


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  //    ------  2   ----   and initiaze it in textformfield
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _username = new TextEditingController();

  bool isloading=false;

  var _formkey = GlobalKey<FormState>();

  Future<void> signup(BuildContext context) async{

    setState(() {
      isloading=true;
    });

    Fluttertoast.showToast(msg: "Successfull");


    if (_formkey.currentState.validate()){
      try{
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email.text, password: _password.text).then((user){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn()));
              Fluttertoast.showToast(msg: "Successfull");
        }).catchError((onError){
          Fluttertoast.showToast(msg: "error" + FlutterError.onError.toString());
        });
      }catch(e){
        print(e);
      }
    }

    setState(() {
      isloading=false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //body: isloading ? CircularProgressIndicator() : Container(
      body: isloading ? Center(child: CircularProgressIndicator(
        // strokeWidth: 20,
      )) : Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.redAccent,
        alignment: Alignment.center,
        margin: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(left: 30 , right: 30),
                  padding: EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(30)

                  ),
                  child: TextFormField(
                    validator: (item){
                      return item.length > 0 ? null : " Enter Valid Name";
                    },
                    controller: _username,
                    decoration: InputDecoration(
                      hintText: "UserName",
                      icon: Icon(Icons.person , color: Colors.black,),
                      labelText: "Enter User Name",
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(left: 30 , right: 30),
                  padding: EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(30)

                  ),
                  child: TextFormField(
                    validator:  (item){
                      return item.contains("@") ? null : "Enter Valid Email";
                    },
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: "Email",
                      icon: Icon(Icons.email , color: Colors.black,),
                      labelText: "Email",

                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(left: 30 , right: 30),
                  padding: EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(30)

                  ),
                  child: TextFormField(
                    validator: (item){
                      return item.length > 0 ? null : " Enter Valid Name";
                    },
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter password Here",
                      icon: Icon(Icons.lock , color: Colors.black,),
                      labelText: "Enter Password",

                    ),
                  ),
                ),
                SizedBox(height: 30),

                Container(
                  height: 40,
                  width: 120,

                  child: FlatButton(
                    child: Text("SignUp"),
                    onPressed: (){
                      signup(context);
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
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: FlatButton(
                    child: Text("Log In"),
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignIn()));

                    },
                  ),
                )




              ],
            ),
          ),
        )
      )
    );
  }
}


