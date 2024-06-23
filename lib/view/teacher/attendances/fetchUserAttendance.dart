import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/controller/userAttendanceController.dart';
import 'package:intl/intl.dart';

class TeacherUserAttendancePage extends StatefulWidget {
  const TeacherUserAttendancePage({super.key});

  @override
  State<TeacherUserAttendancePage> createState() =>
      _TeacherUserAttendancePageState();
}

class _TeacherUserAttendancePageState extends State<TeacherUserAttendancePage> {
  final userAttendanceController = Get.put(UserAttendanceController());
  final StudiesController studiesController = Get.find();
  final _dateFormat = DateFormat('EEEE, d MMMM yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Attended',
        style: GoogleFonts.poppins(),
      )),
      body: Obx(() {
        return userAttendanceController.loading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Container(
                      child: ListTile(
                    title: userAttendanceController.userAttendances.isNotEmpty
                        ? Text(
                            '${studiesController.study.value.name}',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                          )
                        : Text(''),
                    subtitle:
                        userAttendanceController.userAttendances.isNotEmpty
                            ? Text(
                                '${DateFormat('EEEE, d MMMM').format(userAttendanceController.userAttendances.first.attendances.datetime)}',
                                style: GoogleFonts.poppins(),
                              )
                            : Text(''),
                  )),
                  Flexible(
                      child: ListView.builder(
                          itemCount:
                              userAttendanceController.userAttendances.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(
                                Icons.assignment_ind_rounded,
                                color: Colors.green,
                              ),
                              title: Text(
                                '${userAttendanceController.userAttendances[index].users.firstName} ${userAttendanceController.userAttendances[index].users.lastName}',
                                style: GoogleFonts.poppins(fontSize: 14.0),
                              ),
                            );
                          }))
                ],
              );
      }),
    );
  }
}
