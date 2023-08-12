import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AppFunctions{
  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {}

  fetchRecords() async {
    var records =
    await FirebaseFirestore.instance.collection('bmi_data').get();
    mapRecords(records);
  }
}