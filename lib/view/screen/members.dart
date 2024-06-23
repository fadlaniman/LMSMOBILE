import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/view/assets/style.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  final EnrollsController enrollController = Get.find();

  @override
  void initState() {
    enrollController.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          child: ListTile(
            title: Text(
              'Teachers',
              style: GoogleFonts.poppins(
                fontSize: 20.0,
                color: primaryColor,
                decorationColor: primaryColor,
              ),
            ),
          ),
          padding: EdgeInsets.only(bottom: 5.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: primaryColor,
              ),
            ),
          )),
      Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: enrollController.users.length,
              itemBuilder: (context, index) {
                return enrollController.users[index].users.level == "2"
                    ? ListTile(
                        title: Text(
                          '${enrollController.users[index].users.firstName} ${enrollController.users[index].users.lastName}',
                          style: GoogleFonts.poppins(
                              fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      )
                    : Container();
              })),
      Container(
          child: ListTile(
            title: Text(
              'Students',
              style: GoogleFonts.poppins(
                fontSize: 20.0,
                color: primaryColor,
                decorationColor: primaryColor,
              ),
            ),
          ),
          padding: EdgeInsets.only(bottom: 5.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: primaryColor,
              ),
            ),
          )),
      Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: enrollController.users.length,
              itemBuilder: (context, index) {
                return enrollController.users[index].users.level == "3"
                    ? ListTile(
                        title: Text(
                          '${enrollController.users[index].users.firstName} ${enrollController.users[index].users.lastName}',
                          style: GoogleFonts.poppins(
                              fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      )
                    : Container();
              })),
    ]);
  }
}
