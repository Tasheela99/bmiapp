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
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Card(
                              color: Colors.red,
                              child: Text("hbjjjhj"),
                            )
                          ],
                        ),
                        Row(),
                        Row(),
                      ],
                    )
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
