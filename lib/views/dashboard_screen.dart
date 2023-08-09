import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/modals/bmi_data_model.dart';
import 'package:myapp/views/previous_records_screen.dart';
import '../constants/app_text_constants.dart';
import '../functions/auth_functions.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

String? dateTime1 = 'Select a Date';

class _DashboardScreenState extends State<DashboardScreen> {
  final authFunctions = Authentication();

  String myAge = "";
  String name = "";
  String addressIs = "";
  String heightResults = "";
  late int height;
  late int weight;
  late double bmi = 0;
  late double bmiValue = 0;
  String selectedGender = "Male";

  Map<String, dynamic> userInfo = {

  };

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        leading: const IconButton(
          onPressed: null,
          icon: Icon(
            FontAwesomeIcons.bars,
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => authFunctions.signOut(),
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Calculate BMI",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ),
                const Image(
                  image: AssetImage(
                    "assets/images/dashboard_image.jpg",
                  ),
                  width: 250,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Name",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.zero),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.zero),
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                      hintText: "Address",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.zero),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.zero),
                      labelText: "Address",
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Weight",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.zero),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.zero),
                      labelText: "Weight",
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Height",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.zero),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.zero),
                      labelText: "Height",
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  onTap: _showDatePicker,
                  decoration: InputDecoration(
                      hintText: dateTime1,
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.zero),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.zero),
                      labelText: "Pick Your Birth Day",
                      labelStyle: const TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Text("Male"),
                      Radio(
                          value: "Male",
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          }),
                      const Text("Female"),
                      Radio(
                          value: "Female",
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          })
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          printData();
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(50),
                                    topEnd: Radius.circular(50))),
                            context: context,
                            builder: (context) => Container(
                              padding: const EdgeInsets.all(50),
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    topLeft: Radius.circular(50)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                   Column(
                                    children: [
                                      Icon(FontAwesomeIcons.circleUser,size: 50),
                                      SizedBox(height: 10,),
                                      Text("Your Details",style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(height: 30,),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Name",
                                                  style: kDashBoardTextStyles),
                                              Text("Address",
                                                  style: kDashBoardTextStyles),
                                              Text("Bmi",
                                                  style: kDashBoardTextStyles),
                                              Text("Bmi Value",
                                                  style: kDashBoardTextStyles),
                                              Text("Age",
                                                  style: kDashBoardTextStyles),
                                              Text("Gender",
                                                  style: kDashBoardTextStyles),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(name,
                                                style: kDashBoardTextStyles),
                                            Text(addressIs,
                                                style: kDashBoardTextStyles),
                                            Text(bmi.toStringAsFixed(2),
                                                style: kDashBoardTextStyles),
                                            Text(heightResults,
                                                style: kDashBoardTextStyles),
                                            Text(myAge,
                                                style: kDashBoardTextStyles),
                                            Text(selectedGender,
                                                style: kDashBoardTextStyles),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () {
                                                setState(() {
                                                  clearTextFields();
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.all(20),
                                                foregroundColor: Colors.white70,
                                                primary: const Color(0xFFee5253),
                                              ),
                                              child: const Text(
                                                "Clear Fields & Exit",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 3),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            addBmiData();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(20),
                                            foregroundColor: Colors.white70,
                                            primary: const Color(0xFF10ac84),
                                          ),
                                          child: const Text(
                                            "Write Data",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 3),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () => Get.to(() => PreviousRecordsScreen()),
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(20),
                                            foregroundColor: Colors.white70,
                                            primary: const Color(0xFF1dd1a1),
                                          ),
                                          child: const Text(
                                            "Show Previous Records",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 3),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                          setState(() {
                            name = nameController.text;
                            addressIs = addressController.text;
                            weight = int.tryParse(weightController.text) ?? 0;
                            height = int.tryParse(heightController.text) ?? 0;
                            heightResults = bmiResult(bmi);
                            bmi = calculateBmi(height: height, weight: weight);
                            selectedGender;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          foregroundColor: Colors.white70,
                          primary: const Color(0xFF10ac84),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          foregroundColor: Colors.white70,
                          primary: const Color(0xFFee5253),
                        ),
                        child: const Text(
                          "Clear Fields",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        calculateAge(value);
      }
      setState(() {
        dateTime1 = DateFormat('yyyy-MM-dd').format(value!);
      });
    });
  }

  double calculateBmi({required int height, required int weight}) {
    return (weight / (height * height)) * 10000;
  }

  static String bmiResult(bmiValue) {
    if (bmiValue >= 25) {
      return "Over Weight";
    } else if (bmiValue > 18.5) {
      return "Normal";
    } else {
      return "Under Weight";
    }
  }

  void calculateAge(DateTime? value) {
    DateTime now = DateTime.now();
    Duration age = now.difference(value!);
    int years = age.inDays ~/ 365;
    int months = (age.inDays % 365) ~/ 30;
    int days = ((age.inDays % 365) % 30);
    setState(() {
      myAge = '$years years, $months months';
    });
  }

  void clearTextFields() {
    nameController.clear();
    addressController.clear();
    ageController.clear();
    weightController.clear();
    heightController.clear();
  }

  void printData() {
    print(nameController.text);
    print(addressIs);
    print(bmi);
    print(heightResults);
    print(myAge);
    print(selectedGender);
  }

  void addBmiData() {
    var document = BmiDataModel(
        name: name,
        address: addressIs,
        myAge: myAge,
        bmi: bmi,
        gender: selectedGender,
        heightResults: heightResults);

    FirebaseFirestore.instance.collection('bmi_data').add(document.toJson());
  }
}
