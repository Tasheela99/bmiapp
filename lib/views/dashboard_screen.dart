import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/app_color_constants.dart';
import 'package:myapp/functions/app_functions.dart';
import 'package:myapp/functions/app_validator_functions.dart';
import 'package:myapp/functions/auth_functions.dart';
import 'package:myapp/views/previous_records_screen.dart';

import '../modals/bmi_data_model.dart';
import 'map_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dashboardFormKey = GlobalKey<FormState>();
  final appData = AppFunctions();
  final auth = Authentication();
  final validators = AppValidators();

  String? currentUserUid;
  String selectedGender = "Male";
  String name = '';
  String address = '';
  DateTime? _selectedBirthday;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  double bmi = 0.0;
  String bmiComment = '';
  String ageText = '';
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    getCurrentUserUid().then((uid) {
      setState(() {
        currentUserUid = uid;
      });
    });
  }

  Future<String?> getCurrentUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return null;
  }


  void printData() {
    print(name);
    print(address);
    print(selectedGender);
    print(_selectedBirthday);
    print(bmi);
    print(bmiComment);
    print(ageText);
  }

  void _calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;

    if (weight >= 25 &&
        weight <= 200 &&
        height >= 100 &&
        height <= 220 &&
        _selectedBirthday != null) {
      setState(() {
        bmi = weight / ((height / 100) * (height / 100));

        if (bmi < 16) {
          bmiComment = 'Severely Underweight';
        } else if (bmi >= 16 && bmi < 18.5) {
          bmiComment = 'Underweight';
        } else if (bmi >= 18.5 && bmi < 25) {
          bmiComment = 'Normal';
        } else if (bmi >= 25 && bmi < 30) {
          bmiComment = 'Overweight';
        } else {
          bmiComment = 'Obese';
        }

        final currentDate = DateTime.now();
        ageText = (currentDate.year - _selectedBirthday!.year).toString();
        if (currentDate.month < _selectedBirthday!.month ||
            (currentDate.month == _selectedBirthday!.month &&
                currentDate.day < _selectedBirthday!.day)) {
          int age = int.parse(ageText);
          ageText = (age - 1).toString();
        }

        submitted = true;
      });
    } else {
      setState(() {
        bmi = 0.0;
        bmiComment = '';
        ageText = '';
        submitted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                auth.signOut();
              },
              child: const Text(
                "LogOut",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user != null) Text("${user.email}"),
              const Column(
                children: [
                  Image(
                    image: AssetImage("assets/images/dashboard_image.jpg"),
                  ),
                ],
              ),
              Form(
                key: _dashboardFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => validators.validateName(value!),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        hintText: 'Enter your address',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => validators.validateAddress(value!),
                      onChanged: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: weightController,
                      decoration: InputDecoration(
                          labelText: 'Weight (kg)',
                          hintText: 'Enter weight',
                          border: const OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value)=>validators.validateWeight(weightController),

                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: heightController,
                      decoration: InputDecoration(
                          labelText: 'Height (cm)',
                          hintText: 'Enter height',
                          border: const OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value)=>validators.validateHeight(heightController),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          _selectedBirthday == null
                              ? 'Select Birthday'
                              : 'Birthday: ${_selectedBirthday!.year}-${_selectedBirthday!.month}-${_selectedBirthday!.day}',
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.calendarDays),
                          onPressed: () {
                            _showDatePicker();
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "Male",
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Male'),
                        Radio(
                          value: "Female",
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                        const Text('Female'),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if(areAllFieldsValid()){
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  context: context,
                                  builder: (context) => Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            const Text("Your Details"),
                                            if (submitted)
                                              Column(
                                                children: [
                                                  const SizedBox(height: 16.0),
                                                  Text('Age: $ageText'),
                                                  Text('Name: $name'),
                                                  Text('Address: $address'),
                                                  Text('Gender: $selectedGender'),
                                                  Text(
                                                      'BMI: ${bmi.toStringAsFixed(2)}'),
                                                  Text(
                                                      'BMI Comment: $bmiComment'),
                                                ],
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                    final bmiDataModel = BmiDataModel(
                                                      userId: currentUserUid,
                                                      name: name,
                                                      address: address,
                                                      ageText: ageText,
                                                      bmi: bmi,
                                                      selectedGender: selectedGender,
                                                      bmiComment: bmiComment,
                                                      timestamp: Timestamp.now(),
                                                    );
                                                    appData.addBmiData(bmiDataModel);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding:
                                                  const EdgeInsets.all(20),
                                                  backgroundColor:
                                                  const Color(0xFF1dd1a1),
                                                  foregroundColor: Colors.white,
                                                ),
                                                child: const Text('Write Data'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Get.to(() => PreviousRecordsScreen(currentUserUid: currentUserUid));

                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding:
                                                  const EdgeInsets.all(20),
                                                  backgroundColor:
                                                  const Color(0xFF10ac84),
                                                  foregroundColor: Colors.white,
                                                ),
                                                child: const Text(
                                                    'Previous Records'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  resetFields();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding:
                                                  const EdgeInsets.all(20),
                                                  backgroundColor:
                                                  const Color(0xFFee5253),
                                                  foregroundColor: Colors.white,
                                                ),
                                                child: const Text('Exit'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                _calculateBMI();
                                printData();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: kPrimaryBtnColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              resetFields();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: const Color(0xFFee5253),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Reset Fields'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => GoogleMapScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: const Color(0xFFee5253),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('My Location'),
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
    );
  }

  void _showDatePicker() async {
    final currentDate = DateTime.now();
    final initialDate = _selectedBirthday ?? currentDate;

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: currentDate,
    );

    if (selectedDate != null) {
      setState(() {
        _selectedBirthday = selectedDate;
      });
    }
  }

  void resetFields() {
    nameController.clear();
    addressController.clear();
    weightController.clear();
    heightController.clear();
  }
  bool areAllFieldsValid() {
    return _dashboardFormKey.currentState != null &&
        _dashboardFormKey.currentState!.validate() &&
        validators.validateWeight(weightController) == null &&
        validators.validateHeight(heightController) == null;
  }
}
