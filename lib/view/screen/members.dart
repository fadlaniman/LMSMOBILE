import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/classController.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/view/assets/style.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  final enrollsController = Get.put(EnrollsController());

  @override
  void initState() {
    super.initState();
    enrollsController.showEnrolls();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: <Widget>[
        ListTile(
            title: Container(
          child: Container(
            padding: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: primaryColor,
                ),
              ),
            ),
            child: Text(
              'Teachers',
              style: GoogleFonts.poppins(
                fontSize: 20.0,
                color: primaryColor,
                decorationColor: primaryColor,
              ),
            ),
          ),
        )),
        ListTile(
          title: Text(
            enrollsController.enrollsByCode['author'],
            style: GoogleFonts.poppins(
                fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
        ),
        ListTile(
            title: Container(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: primaryColor,
                ),
              ),
            ),
            child: Text(
              'Students',
              style: GoogleFonts.poppins(
                fontSize: 20.0,
                color: primaryColor,
                decorationColor: primaryColor,
              ),
            ),
          ),
        )),
      ]),
    );
  }
}
