import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/constants/app_color_constants.dart';
import 'package:myapp/views/dashboard_screen.dart';

import '../functions/auth_functions.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  final auth = Authentication();
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(7.446555058883363, 80.60727791586429);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: ()=>Get.to(()=>const DashboardScreen()),
                      icon: const Icon(FontAwesomeIcons.houseChimneyUser,color: kPrimaryBtnColor,)),
                  const Spacer(),
                  TextButton(
                    onPressed: (){
                      auth.signOut();
                    },
                    child: const Text("LogOut"),
                  )
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              // LayoutBuilder(
              //   builder: (BuildContext context, BoxConstraints constraints) {
              //     return Image.asset(
              //       "assets/images/my_location_image.jpg",
              //       width: constraints.maxWidth,
              //     );
              //   },
              // ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "My Location",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF385a64),
                          ),
                        ),
                      ),
                      // Add more widgets horizontally as needed
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height*0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}