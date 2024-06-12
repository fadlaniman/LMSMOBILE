import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/authController.dart';
import 'package:mobile/controller/usersController.dart';

class NavigationDrawerWidget extends StatelessWidget {
  NavigationDrawerWidget({super.key});
  final authController = Get.put(AuthController());
  final usersController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(
              'Lemess',
              style: GoogleFonts.poppins(
                  fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            color: Colors.blueAccent[100],
            child: ListTile(
              title: Text(
                'Home',
                style: GoogleFonts.poppins(
                    fontSize: 14.0, fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.dashboard_sharp,
                size: 25.0,
              ),
              onTap: () {},
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListTile(
              iconColor: Colors.grey.shade700,
              title: Text(
                'Logout',
                style: GoogleFonts.poppins(fontSize: 14.0),
              ),
              leading: Icon(
                Icons.exit_to_app,
              ),
              onTap: () => authController.logout(),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
