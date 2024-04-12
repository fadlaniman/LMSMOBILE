import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/classesController.dart';
import 'package:mobile/controller/classroomController.dart';
import 'package:mobile/model/classroomModel.dart';
import 'package:mobile/view/widgets/input.dart';
import 'package:mobile/view/widgets/textButton.dart';

class UpdatedClassPage extends StatefulWidget {
  const UpdatedClassPage({super.key});

  @override
  State<UpdatedClassPage> createState() => _UpdatedClassPageState();
}

class _UpdatedClassPageState extends State<UpdatedClassPage> {
  // final classes = Get.put(ClassesController());
  // final classRoom = Get.put(ClassroomController());
  final name = TextEditingController();
  final section = TextEditingController();
  final subject = TextEditingController();

  // @override
  // void initState() {
  //   classRoom.showClass();
  //   super.initState();
  // }

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
                  Button(
                      title: 'Edit class',
                      onPress: () {
                        // classes.updateClass(
                        //     id: 1,
                        //     name: name.text,
                        //     section: section.text,
                        //     subject: subject.text);
                      }),
                ])),
        body: Obx(() {
          // Classroom userClass = classRoom.dataList.value[0];
          return Container(
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
                InputWidget(controller: section, title: 'Section'),
                SizedBox(
                  height: 30.0,
                ),
                InputWidget(controller: subject, title: 'Subject')
              ],
            ),
          );
        }));
  }
}
