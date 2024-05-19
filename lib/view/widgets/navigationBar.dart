import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/screen/attendances.dart';
import 'package:mobile/view/screen/classwork.dart';
import 'package:mobile/view/screen/members.dart';
import 'package:mobile/view/teacher/assignment.dart';
import 'package:mobile/view/teacher/material.dart';
import 'package:mobile/view/widgets/floatingButtonBottom.dart';
import 'package:mobile/view/widgets/navigationDrawer.dart';
import 'package:mobile/view/widgets/showBottom.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int _selectedIndex = 0;
  final enrollsController = Get.put(EnrollsController());
  final usersController = Get.put(UsersController());

  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(enrollsController.enrollsByCode.value['name'])),
      drawer: NavigationDrawerWidget(),
      floatingActionButton: usersController.userData.value['role'] != 'teacher'
          ? null
          : FloatingButtonWidget(
              color: Colors.white,
              backgroundColor: primaryColor,
              onPress: () {
                ShowBottom().showModalBottom(
                    context,
                    Wrap(
                      children: [
                        ListTile(
                          title: Text(
                            'Create',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                        ListTile(
                          title: Text('Assignment'),
                          leading: Icon(Icons.assignment_outlined),
                          onTap: () {
                            Navigator.of(context).pop();
                            Get.to(() => CreateAssignment());
                          },
                        ),
                        ListTile(
                          title: Text('Material'),
                          leading: Icon(Icons.class_outlined),
                          onTap: () {
                            Navigator.of(context).pop();
                            Get.to(() => CreateMaterial());
                          },
                        )
                      ],
                    ));
              },
            ),
      body: <Widget>[
        AttendancesPage(),
        ClassWorkPage(),
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
    icon: Icon(Icons.assessment_outlined),
    activeIcon: Icon(Icons.assessment),
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
