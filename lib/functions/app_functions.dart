import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modals/bmi_data_model.dart';

class AppFunctions{

  addBmiData(BmiDataModel bmiDataModel) async{

    await FirebaseFirestore.instance
        .collection('bmi_data')
        .add(bmiDataModel.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Data Added SuccessFully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[200],
          colorText: Colors.blue),
    )
        // ignore: body_might_complete_normally_catch_error
        .catchError((err, stackTrace) {
      Get.snackbar("Error", "Something Went Wrong",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green[200],
          colorText: Colors.red);
      print(err.toString());
    });
  }

}