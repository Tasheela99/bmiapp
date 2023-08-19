import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapp/modals/user_model.dart';
import 'package:myapp/views/signin_screen.dart';
import '../views/dashboard_screen.dart';

class Authentication {
  signInWithEmailAndPassword(
      TextEditingController email, TextEditingController password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .whenComplete(
          () => Get.snackbar("Success", "Welcome to Your Dashboard",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green[200],
              colorText: Colors.blue),
        )
        .catchError((err, stackTrace) {
      Get.snackbar("Error", "Something Went Wrong",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[200],
          colorText: Colors.red);
      print(err.toString());
    }).then((value) {
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

  resetPassword(BuildContext context, TextEditingController controller) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
            email: controller.text,
          )
          .whenComplete(
            () => Get.snackbar(
                "Success", "Password Reset Email Send SuccessFully",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green[200],
                colorText: Colors.blue),
          )
          .catchError((err, stackTrace) {
        Get.snackbar("Error", "Something Went Wrong",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green[200],
            colorText: Colors.red);
        print(err.toString());
      });
    } catch (error) {
      print(error);
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    Get.to(() => const SignInScreen());
  }

  getUserName() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String email = currentUser.email ?? '';
    }
  }

  createUser(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add(userModel.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "User Created SuccessFully",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green[200],
              colorText: Colors.blue),
        )
        .catchError((err, stackTrace) {
      Get.snackbar("Error", "Something Went Wrong",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[200],
          colorText: Colors.red);
      print(err.toString());
    });
  }
}
