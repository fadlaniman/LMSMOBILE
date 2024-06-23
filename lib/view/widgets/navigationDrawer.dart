import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/authController.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/view/admin/dashboard.dart';
import 'package:mobile/view/student/home.dart';
import 'package:mobile/view/teacher/home.dart';

class NavigationDrawerWidget extends StatelessWidget {
  NavigationDrawerWidget({super.key});
  final authController = Get.put(AuthController());
  final enrollsController = Get.put(EnrollsController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Lemess',
              style: GoogleFonts.poppins(
                  fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
          ),
          Flexible(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: ListTile(
              title: Text(
                'Home',
                style: GoogleFonts.poppins(
                    fontSize: 14.0, fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.dashboard_outlined,
                size: 25.0,
              ),
              onTap: () {
                switch (authController.user['level']) {
                  case '1':
                    Get.to(() => const Dashboard());
                  case '2':
                    Get.to(() => const HomeTeacherPage());
                  case '3':
                    Get.to(() => const HomeStudentPage());
                }
              },
            ),
          )),
          authController.user['level'] != '1'
              ? Flexible(
                  child: ListView.builder(
                      itemCount: enrollsController.enrolls.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: ListTile(
                              leading: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.primaries[
                                        index % Colors.primaries.length],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.book_outlined,
                                    color: Colors.primaries[
                                        index % Colors.primaries.length],
                                  )),
                              title: Text(
                                enrollsController.enrolls[index].classes.name,
                                style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                enrollsController
                                    .enrolls[index].classes.description,
                                style: GoogleFonts.poppins(fontSize: 13.0),
                              ),
                            ));
                      }))
              : Container(),
          Flexible(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
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
          )),
        ],
      ),
    );
    ;
  }
}
