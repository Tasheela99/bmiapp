import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/views/signin_screen.dart';
import '../views/dashboard_screen.dart';

class Authentication {


  signInWithEmailAndPassword(
      TextEditingController email,
      TextEditingController password
      ) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
      Get.to(() => const DashboardScreen());
    }).onError((error, stackTrace) {
      print("Error Is ${error.toString()}");
    });
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleSignInAuth =
    await googleSignInAccount?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth?.accessToken,
        idToken: googleSignInAuth?.idToken);
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user != null) {
      Get.to(() => const DashboardScreen());
    }
  }

  signOut(){
    FirebaseAuth.instance.signOut();
    Get.to(()=> const SignInScreen());
  }

}
