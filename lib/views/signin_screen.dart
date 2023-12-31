import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/app_btn_text_constants.dart';
import 'package:myapp/constants/app_color_constants.dart';
import 'package:myapp/functions/app_validator_functions.dart';
import 'package:myapp/views/forget_password_screen.dart';
import 'package:myapp/views/signup_screen.dart';
import '../functions/auth_functions.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final signInForm = GlobalKey<FormState>();
  final authFunctions = Authentication();
  final validators = AppValidators();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Image.asset(
                      "assets/images/sign_in_image.jpg",
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
                            "Welcome",
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Sign in to continue")),
                ),
                Form(
                    key: signInForm,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email),

                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => validators.validateEmail(value!),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.fingerprint),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey,
                              ),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          obscureText: _obscureText,
                          validator: (value) => validators.validatePassword(value!),

                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Get.to(() => const ForgetPasswordScreen()),
                            child: const Text(
                              "Forget Password?",
                              style: TextStyle(
                                color: Color(0xFF485460),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  if (signInForm.currentState!.validate()) {
                                    signInForm.currentState!.save();
                                    authFunctions.signInWithEmailAndPassword(
                                        email, password);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: kPrimaryBtnColor,
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
                      ],
                    )),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.to(() => const SignUpScreen()),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          backgroundColor: kSecondaryBtnColor,
                          foregroundColor: Colors.white70,
                        ),
                        child: const Text(
                          "Sign Up",
                          style: kBtnStyles,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    "OR SIGN IN WITH",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
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
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () => authFunctions.signInWithGoogle(),
                        icon: const Icon(
                          FontAwesomeIcons.google,
                          color: Color(0xFFDB4437),
                        ),
                        label: const Text("GOOGLE"),
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
                            color: Colors.black,
                          ),
                        ),
                        onPressed: null,
                        icon: const Icon(
                          FontAwesomeIcons.facebook,
                          color: Color(0xFF4267B2),
                        ),
                        label: const Text("FACEBOOK"),
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
                            color: Colors.black,
                          ),
                        ),
                        onPressed: null,
                        icon: const Icon(
                          FontAwesomeIcons.twitter,
                          color: Color(0xFF1DA1F2),
                        ),
                        label: const Text("TWITTER"),
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
