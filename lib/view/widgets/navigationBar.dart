import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/authController.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/screen/members.dart';
import 'package:mobile/view/student/fetch-attendance.dart';
import 'package:mobile/view/student/fetch-classwork.dart';
import 'package:mobile/view/teacher/attendances/fetch-attendance.dart';
import 'package:mobile/view/teacher/attachments/fetch-classwork.dart';
import 'package:mobile/view/widgets/navigationDrawer.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int _selectedIndex = 0;
  final AuthController authController = Get.find();
  final EnrollsController enrollController = Get.find();
  final StudiesController studiesController = Get.find();

  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Obx(() => Text(studiesController.study.value.name ?? ''))),
      drawer: NavigationDrawerWidget(),
      body: <Widget>[
        authController.user['level'] == '2'
            ? const TeacherAttendancePage()
            : const StudentAttendancePage(),
        authController.user['level'] == '2'
            ? const TeacherClassWorkPage()
            : const StudentClassWorkPage(),
        MembersPage(),
      ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: const Color(0xff757575),
          type: _bottomNavType,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.assignment_ind_outlined),
    activeIcon: Icon(Icons.assignment_ind),
    label: 'Attendance',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.assignment_outlined),
    activeIcon: Icon(Icons.assignment),
    label: 'Classwork',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.people_alt_outlined),
    activeIcon: Icon(Icons.people_alt),
    label: 'Members',
  ),
];
