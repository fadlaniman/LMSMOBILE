import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/classesController.dart';
import 'package:mobile/controller/classroomController.dart';
import 'package:mobile/model/classroomModel.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  final classRoom = Get.put(ClassroomController());
  final studies = Get.put(ClassesController());

  @override
  void initState() {
    classRoom.showClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Obx(() {
      return Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 20.0),
          child: Container(
              padding: EdgeInsetsDirectional.only(end: 20),
              child: ListView.builder(
                  itemCount: classRoom.dataList.value[0].classes.length,
                  itemBuilder: (context, index) {
                    Classroom userClass = classRoom.dataList.value[0];
                    return Container(
                        child: TextButton.icon(
                      onPressed: () {
                        studies.showClass(id: userClass.classes[index].id);
                      },
                      icon: Icon(
                        Icons.circle,
                        size: 30.0,
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                      ),
                      label: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userClass.classes[index].name,
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              userClass.classes[index].section,
                              style: TextStyle(color: Colors.grey.shade600),
                            )
                          ]),
                      style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10.0))),
                    ));
                  })));
    }));
  }
}
