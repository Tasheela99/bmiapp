import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/views/dashboard_screen.dart';

class PreviousRecordsScreen extends StatelessWidget {
  const PreviousRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () => Get.to(() => const DashboardScreen()),
                      icon: const Icon(
                        FontAwesomeIcons.circleArrowLeft,
                        size: 40,
                        color: Color(0xFF1dd1a1),
                      ),

                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                      "assets/images/previous_records_image.jpg",
                    ),
                    width: 450,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                          child: Text(
                            "Previous Results",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF385a64),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xa91dd1a1),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.calendarDay,color: Color(0xFFffffff),),
                                      SizedBox(width: 50,),
                                      Text("2023-08-09"),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        Icon(FontAwesomeIcons.listNumeric,color: Color(0xFFffffff),),
                                        SizedBox(width: 50,),
                                        Text("25.7"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.heart,color: Color(0xFFffffff),),
                                      SizedBox(width: 50,),
                                      Text("Normal"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xa91dd1a1),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.calendarDay,color: Color(0xFFffffff),),
                                      SizedBox(width: 50,),
                                      Text("2023-08-09"),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        Icon(FontAwesomeIcons.listNumeric,color: Color(0xFFffffff),),
                                        SizedBox(width: 50,),
                                        Text("25.7"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.heart,color: Color(0xFFffffff),),
                                      SizedBox(width: 50,),
                                      Text("Normal"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xa91dd1a1),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.calendarDay,color: Color(0xFFffffff),),
                                      SizedBox(width: 50,),
                                      Text("2023-08-09"),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        Icon(FontAwesomeIcons.listNumeric,color: Color(0xFFffffff),),
                                        SizedBox(width: 50,),
                                        Text("25.7"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.heart,color: Color(0xFFffffff),),
                                      SizedBox(width: 50,),
                                      Text("Normal"),
                                    ],
                                  ),
                                ],
                              ),
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
    );
  }
}
