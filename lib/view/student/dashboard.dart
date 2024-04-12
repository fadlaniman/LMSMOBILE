import 'package:flutter/material.dart';
import 'package:mobile/controller/classroomController.dart';
import 'package:mobile/model/classroomModel.dart';
import 'package:mobile/view/student/joinClass.dart';
import 'package:mobile/view/widgets/header.dart';
import 'package:mobile/view/widgets/navigationTop.dart';
import 'package:get/get.dart';
import 'package:mobile/view/widgets/floatingButtonBottom.dart';
import 'package:mobile/view/widgets/showBottom.dart';

class DashboardStudent extends StatefulWidget {
  const DashboardStudent({super.key});

  @override
  State<DashboardStudent> createState() => _DashboardStudentState();
}

class _DashboardStudentState extends State<DashboardStudent> {
  final classRoom = Get.put(ClassroomController());

  @override
  void initState() {
    classRoom.showClass();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Header(title: 'Student'),
        ),
        drawer: NavigationWidget(),
        floatingActionButton: FloatingButtonWidget(
          onPress: () {
            ShowBottom().showModalBottom(context, title: 'Join class',
                onTap: () {
              Navigator.of(context).pop();
              Get.to(() => Classes());
            });
          },
        ),
        body: Obx(() {
          return classRoom.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                      child: ListView.builder(
                    itemCount: classRoom.dataList.value[0].classes.length,
                    itemBuilder: ((context, index) {
                      Classroom UserClass = classRoom.dataList.value[0];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors
                                .primaries[index % Colors.primaries.length]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  UserClass.classes[index].name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  UserClass.classes[index].section,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  UserClass.username,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            IconButton(
                                padding: EdgeInsets.all(0.0),
                                onPressed: () {
                                  ShowBottom().showModalBottom(context,
                                      title: 'Unenroll', onTap: () {
                                    Navigator.of(context).pop();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          title: Text(
                                            "Unenroll",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          content: Text(
                                            "By doing this you won't be able to see or participate in the class anymore",
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await classRoom.UnenrollClass(
                                                    id: UserClass
                                                        .classes[index].id);
                                                classRoom.dataList.clear();
                                                classRoom.showClass();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Unenroll",
                                                  style: TextStyle(
                                                      color: Colors.blue)),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  });
                                },
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 25.0,
                                )),
                          ],
                        ),
                      );
                    }),
                  )));
        }));
  }
}
