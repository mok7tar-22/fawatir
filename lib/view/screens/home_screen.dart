import 'package:fawatir_app/utils/constants.dart';
import 'package:fawatir_app/view/screens/authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName="HomeScreen";

 HomeScreen({Key? key}) : super(key: key);
  String? email= FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(email!),
                ElevatedButton(onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                }, child: Text("log out"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
