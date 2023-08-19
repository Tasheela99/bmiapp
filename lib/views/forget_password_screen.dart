import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/functions/app_validator_functions.dart';
import 'package:myapp/views/signin_screen.dart';

import '../constants/app_btn_text_constants.dart';
import '../constants/app_color_constants.dart';
import '../constants/app_text_constants.dart';
import '../functions/auth_functions.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final forgetPasswordForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  final validators = AppValidators();
  final authFunctions = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                    image: AssetImage("assets/images/forget_password_image.jpg")),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Forgot Your Password?",
                      style: kSignUpAndSignInPageTitleStyles,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text("Let's Get Your Account Back..."),
                  ],
                ),
                SizedBox(height: 50,),
                Form(
                  key: forgetPasswordForm,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Your Email to Reset Your Password',
                          prefixIcon: Icon(Icons.email),

                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => validators.validateEmail(value!),
                      ),
                      SizedBox(height: 25,),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                if (forgetPasswordForm.currentState!.validate()) {
                                  forgetPasswordForm.currentState!.save();
                                  authFunctions.resetPassword(context, email);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20),
                                backgroundColor: kPrimaryBtnColor,
                                foregroundColor: Colors.white70,
                              ),
                              child: const Text(
                                "Continue",
                                style: kBtnStyles,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text("OR",style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: ()=> Get.to(()=>SignInScreen()),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20),
                                backgroundColor: kSecondaryBtnColor,
                                foregroundColor: Colors.white70,
                              ),
                              child: const Text(
                                "Sign In Again",
                                style: kBtnStyles,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
