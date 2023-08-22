import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/constants/app_color_constants.dart';
import 'package:myapp/views/dashboard_screen.dart';

import '../constants/app_text_constants.dart';
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const Image(image: AssetImage("assets/images/my_location_image.jpg"),width: 400),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Find Me In Here",
                      style: kSignUpAndSignInPageTitleStyles,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  width: 450,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition:
                        CameraPosition(target: _center, zoom: 11.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}