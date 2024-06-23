import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/attendanceController.dart';
import 'package:mobile/controller/authController.dart';
import 'package:mobile/controller/userAttendanceController.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:intl/intl.dart';

class StudentAttendancePage extends StatefulWidget {
  const StudentAttendancePage({super.key});

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  final attendanceController = Get.put(AttendanceController());
  final userAttendanceController = Get.put(UserAttendanceController());
  final authController = Get.put(AuthController());
  List<String> selectedOptions = [];
  bool isPresentChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.0,
          ),
          child: Obx(() {
            int length = attendanceController.attendances.length + 1;
            return attendanceController.loading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: attendanceController.attendances.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return AlertDialog(
                                      title: Text(
                                        'Submit',
                                        style:
                                            GoogleFonts.poppins(fontSize: 18.0),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      titleTextStyle: GoogleFonts.poppins(
                                          color: Colors.black),
                                      content: CheckboxListTile(
                                        title: ListTile(
                                            title: Text(
                                          'Present',
                                          style: GoogleFonts.poppins(),
                                        )),
                                        value: isPresentChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isPresentChecked = value ?? false;
                                            if (isPresentChecked) {
                                              selectedOptions.add('Present');
                                            } else {
                                              selectedOptions.remove('Present');
                                            }
                                          });
                                        },
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Send'),
                                          onPressed: () {
                                            if (isPresentChecked) {
                                              userAttendanceController.send(
                                                  attendanceController
                                                      .attendances[index].id,
                                                  authController.user['uid'],
                                                  attendanceController
                                                      .attendances[index]
                                                      .classId);
                                              Navigator.of(context).pop();
                                            } else {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border:
                                      Border.all(color: Colors.grey.shade400)),
                              child: ListTile(
                                  leading: Container(
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check_box_outlined,
                                        color: Colors.white,
                                      )),
                                  title: Text(
                                    'Attendance ${length -= 1}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                      DateFormat('EEEE, d MMMM').format(
                                          attendanceController
                                              .attendances[index].datetime
                                              .toLocal()),
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey.shade600,
                                          fontSize: 12.0,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500))),
                            ),
                            SizedBox(
                              height: 5.0,
                            )
                          ],
                        ),
                      );
                    }));
          })),
    );
  }
}
