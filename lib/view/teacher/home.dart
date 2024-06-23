import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/attachmentController.dart';
import 'package:mobile/controller/attendanceController.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/controller/userAttendanceController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/widgets/navigationBar.dart';
import 'package:mobile/view/widgets/title.dart';
import 'package:get/get.dart';
import 'package:mobile/view/widgets/navigationDrawer.dart';

class HomeTeacherPage extends StatefulWidget {
  const HomeTeacherPage({super.key});

  @override
  State<HomeTeacherPage> createState() => _HomeTeacherPageState();
}

class _HomeTeacherPageState extends State<HomeTeacherPage> {
  final enrollController = Get.put(EnrollsController());
  final usersController = Get.put(UsersController());
  final studiesController = Get.put(StudiesController());
  final attachmentsController = Get.put(AttachmentsController());
  final attendanceController = Get.put(AttendanceController());
  final userAttendanceController = Get.put(UserAttendanceController());

  @override
  void initState() {
    enrollController.fetch();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TitleWidget(),
        ),
        drawer: NavigationDrawerWidget(),
        body: Obx(() {
          return enrollController.loading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: ListView.builder(
                      itemCount: enrollController.enrolls.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                            onTap: () {
                              studiesController.fetchById(
                                  enrollController.enrolls[index].classes.id);
                              enrollController.fetchUsers(
                                  enrollController.enrolls[index].classes.id);
                              attachmentsController.fetch(
                                  enrollController.enrolls[index].classes.id);
                              attendanceController.fetch(
                                  enrollController.enrolls[index].classes.id);
                              Get.to(() => const NavigationBarWidget());
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.primaries[
                                      index % Colors.primaries.length]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${enrollController.enrolls[index].classes.name}',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 1.0,
                                  ),
                                  Text(
                                    enrollController
                                        .enrolls[index].classes.description,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text(
                                    '',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 13.0),
                                  )
                                ],
                              ),
                            ));
                      })));
        }));
  }
}
