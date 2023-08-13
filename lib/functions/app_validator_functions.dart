
import 'package:flutter/cupertino.dart';

class AppValidators {

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[a-zA-Z]).{6,}$')
        .hasMatch(value)) {
      return 'Password must contain at least one letter and one number';
    }
    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Confirm password is required';
    } else if (value != validatePassword) {
      return 'Passwords do not match';
    }
    return null;
  }


  String? validateMobile(String value) {
    if (value.isEmpty) {
      return 'Mobile number is required';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Invalid mobile number';
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }
  String? validateAddress(String value) {
    if (value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  String? validateWeight(TextEditingController weightController) {
    double? weight = double.tryParse(weightController.text);
    if (weight == null || weight < 25 || weight > 200) {
      return 'Enter a valid weight between 25 and 200 kg';
    }
    return null;
  }

  String? validateHeight(TextEditingController heightController) {
    double? height = double.tryParse(heightController.text);
    if (height == null || height < 100 || height > 220) {
      return 'Enter a valid height between 100 and 220 cm';
    }
    return null;
  }


}
