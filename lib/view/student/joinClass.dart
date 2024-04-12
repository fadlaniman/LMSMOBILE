import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/classroomController.dart';
import 'package:mobile/view/widgets/textButton.dart';
import 'package:mobile/view/widgets/header.dart';

final classID = TextEditingController();

class Classes extends StatelessWidget {
  final ClassroomController classRoom = Get.put(ClassroomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close)),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Header(title: 'Join Class'),
            Button(
              title: 'Join',
              onPress: () async {
                await classRoom.enrollClass(id: classID.text);
                classRoom.dataList.value.clear();
                classRoom.showClass();
              },
            )
          ])),
      body: ClassesWidget(),
    );
  }
}

class ClassesWidget extends StatefulWidget {
  const ClassesWidget({super.key});

  @override
  State<ClassesWidget> createState() => _ClassesWidgetState();
}

class _ClassesWidgetState extends State<ClassesWidget> {
  final ClassroomController classRoom = Get.put(ClassroomController());

  @override
  void initState() {
    classRoom.showClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You're currently signed as",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                // Text(
                //   classRoom.dataList.value[0].username,
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                // )
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Text('Ask you teacher for the class ID, then enter it here.'),
            SizedBox(
              height: 15.0,
            ),
            Container(
              child: TextField(
                controller: classID,
                decoration: InputDecoration(
                  labelText: 'Classes ID',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
