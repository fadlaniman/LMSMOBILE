import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/view/widgets/input.dart';
import 'package:mobile/view/widgets/textButton.dart';

class UpdatedClassPage extends StatefulWidget {
  const UpdatedClassPage({super.key});

  @override
  State<UpdatedClassPage> createState() => _UpdatedClassPageState();
}

final enrollsController = Get.put(EnrollsController());

class _UpdatedClassPageState extends State<UpdatedClassPage> {
  final name = TextEditingController(
      text: enrollsController.enrollsByCode.value['name']);
  final section = TextEditingController(
      text: enrollsController.enrollsByCode.value['section']);
  final subject = TextEditingController(
      text: enrollsController.enrollsByCode.value['subject']);

  @override
  void initState() {
    super.initState();
    enrollsController.showEnrolls();
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
                  Text('Edit class'),
                  Button(title: 'Edit class', onPress: () {}),
                ])),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: Column(
              children: [
                InputWidget(
                  keyboardType: TextInputType.text,
                  controller: name,
                  title: 'Class name',
                ),
                SizedBox(
                  height: 30.0,
                ),
                InputWidget(
                    keyboardType: TextInputType.text,
                    controller: section,
                    title: 'Section'),
                SizedBox(
                  height: 30.0,
                ),
                InputWidget(
                    keyboardType: TextInputType.text,
                    controller: subject,
                    title: 'Subject')
              ],
            )));
  }
}
