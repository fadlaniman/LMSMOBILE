import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile/controller/attendanceController.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/controller/userAttendanceController.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/teacher/attendances/fetchUserAttendance.dart';
import 'package:mobile/view/widgets/floatingButtonBottom.dart';

class TeacherAttendancePage extends StatefulWidget {
  const TeacherAttendancePage({super.key});

  @override
  State<TeacherAttendancePage> createState() => _TeacherAttendancePageState();
}

class _TeacherAttendancePageState extends State<TeacherAttendancePage> {
  final userAttendanceController = Get.put(UserAttendanceController());
  final StudiesController studiesController = Get.find();
  final attendanceController = Get.put(AttendanceController());

  final _dateTime = TextEditingController();
  final _dateFormat = DateFormat('EEEE, d MMMM yyyy');

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateTime.text = _dateFormat.format(pickedDate);
      });
    }
  }

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
                          userAttendanceController.fetch(
                              attendanceController.attendances[index].classId,
                              attendanceController.attendances[index].id);
                          Get.to(() => const TeacherUserAttendancePage());
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
                                      Icons.assignment_ind,
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
                                          .attendances[index].datetime),
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade600,
                                      fontSize: 12.0,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            )
                          ],
                        ),
                      );
                    }));
          })),
      floatingActionButton: FloatingButtonWidget(
        color: Colors.white,
        backgroundColor: primaryColor,
        onPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titleTextStyle: GoogleFonts.poppins(color: Colors.black),
                title: const Text(
                  'Create',
                  style: TextStyle(fontSize: 18.0),
                ),
                content: TextFormField(
                  readOnly: true,
                  controller: _dateTime,
                  decoration: InputDecoration(
                    hintText: 'Select Time',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selectDate(context),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Yes'),
                    onPressed: () {
                      attendanceController.send(
                          studiesController.study.value.id ?? '',
                          _dateFormat.parse(_dateTime.text));
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
