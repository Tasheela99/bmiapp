import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../modals/bmi_data_model.dart';
import 'package:intl/intl.dart';

class PreviousRecordsScreen extends StatefulWidget {
  const PreviousRecordsScreen({super.key});

  @override
  State<PreviousRecordsScreen> createState() => _PreviousRecordsScreenState();
}

class _PreviousRecordsScreenState extends State<PreviousRecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const Image(
                  image:
                      AssetImage("assets/images/previous_records_image.jpg")),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Your Previous BMI Records",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF385a64),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('bmi_data')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final data = snapshot.data!.docs;

                    return Scrollbar(
                      isAlwaysShown: true,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final doc = data[index];
                          final bmiData = BmiDataModel.fromJson(
                              doc.data() as Map<String, dynamic>);

                          final formattedTimestamp = bmiData.timestamp != null
                              ? DateFormat.yMMMd()
                                  .format(bmiData.timestamp!.toDate())
                              : 'Unknown';

                          return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: Colors.black,
                                strokeAlign: 0,
                                width: 1

                              )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(FontAwesomeIcons.calendarDays),
                                      const SizedBox(width: 50),
                                      Text(formattedTimestamp),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(FontAwesomeIcons.coins),
                                      const SizedBox(width: 50),
                                      Text(bmiData.bmi.toStringAsFixed(1)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(FontAwesomeIcons.heartCircleCheck,color: Colors.pinkAccent,),
                                      const SizedBox(width: 50),
                                      Text(bmiData.bmiComment),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
