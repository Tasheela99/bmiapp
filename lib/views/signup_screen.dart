import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/functions/app_validator_functions.dart';
import 'package:myapp/views/dashboard_screen.dart';
import '../constants/app_btn_text_constants.dart';
import '../constants/app_color_constants.dart';
import '../constants/app_text_constants.dart';
import '../functions/auth_functions.dart';
import 'package:myapp/views/signin_screen.dart';

import '../modals/user_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final authFunctions = Authentication();
  final validators = AppValidators();


  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: Column(
              children: [
                const Image(
                  image: AssetImage("assets/images/sign_up_image.jpg"),
                  width: 350,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Let's Get Started",
                      style: kSignUpAndSignInPageTitleStyles,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Let's See who you are")),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) => validators.validateName(value!),
                        controller: name,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) => validators.validateEmail(value!),
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),

                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) => validators.validateMobile(value!),
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Mobile',
                          hintText: 'Mobile',
                          prefixIcon: Icon(Icons.phone),

                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) => validators.validatePassword(value!),
                        controller: password,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.fingerprint),

                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text);

                                  final userModel = UserModel(
                                    name: name.text.trim(),
                                    email: email.text.trim(),
                                    phone: phone.text.trim(),
                                  );
                                  authFunctions.createUser(userModel);
                                  Get.to(()=>const DashboardScreen());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20), backgroundColor: kPrimaryBtnColor,
                              ),
                              child: const Text(
                                "Sign Up",
                                style: kBtnStyles,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Already Have An Account?",
                      style: TextStyle(
                          color: Color(0xFF485460),
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.to(() => const SignInScreen()),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20), backgroundColor: const Color(0xFF222f3e),
                          foregroundColor: Colors.white70,
                        ),
                        child: const Text(
                          "Sign In",
                          style: kBtnStyles,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Text(
                    "OR SIGN IN WITH",
                    style: TextStyle(
                        color: Color(0xFF485460), fontWeight: FontWeight.w900),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          side: const BorderSide(
                            color: Color(0xFF485460),
                          ),
                        ),
                        onPressed: () {
                          authFunctions.signInWithGoogle();
                        },
                        icon: const Icon(
                          FontAwesomeIcons.google,
                          color: Color(0xFFDB4437),
                        ),
                        label: const Text(
                          "GOOGLE",
                          style: TextStyle(
                            color: Color(0xFF485460),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          side: const BorderSide(
                            color: Color(0xFF485460),
                          ),
                        ),
                        onPressed: null,
                        icon: const Icon(
                          FontAwesomeIcons.facebook,
                          color: Color(0xFF4267B2),
                        ),
                        label: const Text(
                          "FACEBOOK",
                          style: TextStyle(
                            color: Color(0xFF485460),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          side: const BorderSide(
                            color: Color(0xFF485460),
                          ),
                        ),
                        onPressed: null,
                        icon: const Icon(
                          FontAwesomeIcons.twitter,
                          color: Color(0xFF1DA1F2),
                        ),
                        label: const Text(
                          "TWITTER",
                          style: TextStyle(
                            color: Color(0xFF485460),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
