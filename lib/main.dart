import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:signin_page/main.dart';
import 'package:signin_page/signin.dart';
import 'package:signin_page/splash_screen.dart';
import 'package:signin_page/successful.dart';
import 'signup.dart';

//   ----   1  ----
Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp using Firebase"),
      ),
      body: Center(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: RaisedButton(
                    child: Text("Sign Up"),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                    },
                  ),
                ),
                Center(
                  child: RaisedButton(
                    child: Text("Sign In"),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn()));


                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

