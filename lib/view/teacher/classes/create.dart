import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/classesController.dart';
import 'package:mobile/controller/classroomController.dart';
import 'package:mobile/model/classroomModel.dart';
import 'package:mobile/view/widgets/header.dart';
import 'package:mobile/view/widgets/input.dart';
import 'package:mobile/view/widgets/textButton.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({super.key});

  @override
  State<CreateClassPage> createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  // final classes = Get.put(ClassesController());
  final name = TextEditingController();
  final section = TextEditingController();
  final subject = TextEditingController();
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
                  Text('Create class'),
                  Button(
                      title: 'Create class',
                      onPress: () {
                        // classes.createClass(
                        //     name: name.text,
                        //     section: section.text,
                        //     subject: subject.text);
                      }),
                ])),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Column(
            children: [
              InputWidget(
                controller: name,
                title: 'Class name',
              ),
              SizedBox(
                height: 30.0,
              ),
              InputWidget(controller: subject, title: 'Section'),
              SizedBox(
                height: 30.0,
              ),
              InputWidget(controller: section, title: 'Subject')
            ],
          ),
        ));
  }
}
