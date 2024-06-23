import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/controller/attendanceController.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/view/widgets/textButton.dart';

class CreateAttendancePage extends StatefulWidget {
  const CreateAttendancePage({super.key});

  @override
  State<CreateAttendancePage> createState() => _CreateAttendancePageState();
}

class _CreateAttendancePageState extends State<CreateAttendancePage> {
  final AttendanceController attendanceController = Get.find();
  final StudiesController studiesController = Get.find();
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
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close)),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Attendance'),
                  Button(
                      title: 'Create',
                      onPress: () {
                        attendanceController.send(
                            studiesController.study.value.id ?? '',
                            _dateFormat.parse(_dateTime.text));
                      }),
                ])),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                  readOnly: true,
                  controller: _dateTime,
                  decoration: InputDecoration(
                    hintText: 'Select Time',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selectDate(context),
                ),
              ],
            ),
          ),
        ));
  }
}
