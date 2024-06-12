import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/admin/classes/create.dart';
import 'package:mobile/view/admin/studies/create.dart';
import 'package:mobile/view/admin/users/create.dart';
import 'package:mobile/view/admin/users/read.dart';
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
        title: TitleWidget(),
      ),
      body: Container(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              onTap: () => Get.to(() => const ReadUsersPage()),
              child: Container(
                padding: EdgeInsets.all(20.0),
                color: Colors.blue,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          size: 35,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Users',
                              style: GoogleFonts.poppins(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                            Text('50', style: GoogleFonts.poppins())
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(20.0),
                color: Colors.green,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.class_outlined,
                          size: 35,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Classes',
                              style: GoogleFonts.poppins(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                            Text('50', style: GoogleFonts.poppins())
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
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
                    leading: Icon(Icons.people_alt_outlined),
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => CreateUsersPage());
                    },
                  ),
                  ListTile(
                    title: Text('Studies'),
                    leading: Icon(Icons.bookmark_added_outlined),
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => CreateStudiesPage());
                    },
                  ),
                  ListTile(
                    title: Text('Classes'),
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
