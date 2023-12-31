import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/functions/app_validator_functions.dart';
import 'package:myapp/views/signin_screen.dart';

import '../constants/app_btn_text_constants.dart';
import '../constants/app_color_constants.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Image.asset(
                      "assets/images/forget_password_image.jpg",
                      width: constraints.maxWidth, // Adjust width based on constraints
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Forgot Your Password?",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF385a64),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Text("Let's Get Your Account Back..."),
                  ],
                ),
                const SizedBox(height: 20,),
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
                      const SizedBox(height: 25,),
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text("OR",style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: ()=> Get.to(()=>const SignInScreen()),
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
