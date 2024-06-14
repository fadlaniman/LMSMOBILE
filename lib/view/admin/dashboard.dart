import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/admin/classes/create.dart';
import 'package:mobile/view/admin/studies/create-studies.dart';
import 'package:mobile/view/admin/studies/fetch-studies.dart';
import 'package:mobile/view/admin/users/create-users.dart';
import 'package:mobile/view/admin/users/fetch-users.dart';
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
          child: SingleChildScrollView(
              child: Column(children: [
        SizedBox(
          height: 25.0,
        ),
        // AccountBalance(),
        SizedBox(
          height: 40.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            color: Color.fromRGBO(97, 99, 119, 1),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Total record ",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const ReadUsersPage());
                  },
                  child: Container(
                    height: 90.0,
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Row(children: [
                      Icon(
                        Icons.group_outlined,
                        size: 35.0,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Users',
                            style: GoogleFonts.poppins(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                          Text(usersController.users.length.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16.0,
                              ))
                        ],
                      )
                    ]),
                  )),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                  onTap: () {
                    Get.to(() => const ReadStudiesPage());
                  },
                  child: Container(
                    height: 90.0,
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Row(children: [
                      Icon(
                        Icons.bookmark_outline,
                        size: 35.0,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Studies',
                            style: GoogleFonts.poppins(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                          Text(usersController.users.length.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16.0,
                              ))
                        ],
                      )
                    ]),
                  ))
            ],
          ),
        ),
      ]))),
      drawer: NavigationDrawerWidget(),
    );
  }
}
