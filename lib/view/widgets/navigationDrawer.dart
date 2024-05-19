import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/authController.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/admin/classes/update.dart';
import 'package:mobile/view/admin/dashboard.dart';
import 'package:mobile/view/screen/home.dart';

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
              'Kritis app'.toUpperCase(),
              style: GoogleFonts.poppins(
                  fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            iconColor: Colors.grey.shade700,
            title: Text(
              'Home',
              style: GoogleFonts.poppins(
                fontSize: 14.0,
              ),
            ),
            leading: Icon(
              Icons.home_outlined,
            ),
            onTap: () {},
          ),
          ListTile(
            iconColor: Colors.grey.shade700,
            title: Text(
              'Logout',
              style: GoogleFonts.poppins(fontSize: 14.0),
            ),
            leading: Icon(
              Icons.logout_outlined,
            ),
            onTap: () => authController.logout(),
          ),
        ],
      ),
    );
    ;
  }
}
