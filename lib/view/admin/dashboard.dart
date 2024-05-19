import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/admin/classes/create.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/widgets/floatingButtonBottom.dart';
import 'package:mobile/view/widgets/navigationDrawer.dart';
import 'package:mobile/view/widgets/showBottom.dart';
import 'package:mobile/view/widgets/title.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final usersController = Get.put(UsersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(title: usersController.userData.value['role']),
      ),
      drawer: NavigationDrawerWidget(),
      floatingActionButton: FloatingButtonWidget(
        backgroundColor: Colors.white,
        color: primaryColor,
        onPress: () {
          ShowBottom().showModalBottom(
              context,
              Wrap(
                children: [
                  ListTile(
                    title: Text(
                      'Manage',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  ListTile(
                    title: Text('Users'),
                    leading: Icon(Icons.people_outline),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text('Class'),
                    leading: Icon(Icons.class_outlined),
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => CreateClassPage());
                    },
                  ),
                ],
              ));
        },
      ),
    );
  }
}
