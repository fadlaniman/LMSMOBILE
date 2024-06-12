import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/classController.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/admin/classes/create.dart';
import 'package:mobile/view/admin/classes/update.dart';
import 'package:mobile/view/widgets/navigationBar.dart';
import 'package:mobile/view/widgets/navigationDrawer.dart';
import 'package:get/get.dart';
import 'package:mobile/view/widgets/floatingButtonBottom.dart';
import 'package:mobile/view/widgets/showBottom.dart';
import 'package:mobile/view/widgets/title.dart';

class DashboardTeacher extends StatefulWidget {
  const DashboardTeacher({super.key});

  @override
  State<DashboardTeacher> createState() => _DashboardTeacherState();
}

class _DashboardTeacherState extends State<DashboardTeacher> {
  final enrollsController = Get.put(EnrollsController());
  final classController = Get.put(ClassController());

  @override
  void initState() {
    super.initState();
    enrollsController.showEnrolls();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TitleWidget(),
        ),
        drawer: NavigationDrawerWidget(),
        floatingActionButton: FloatingButtonWidget(
          color: primaryColor,
          backgroundColor: Colors.white,
          onPress: () {
            ShowBottom().showModalBottom(
                context,
                Wrap(
                  children: [
                    ListTile(
                      title: Text('Create class'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => CreateClassPage());
                      },
                    )
                  ],
                ));
          },
        ),
        body: Obx(() {
          return enrollsController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                      child: ListView.builder(
                    itemCount: enrollsController.enrolls.length,
                    itemBuilder: ((context, index) {
                      List codes = [];
                      enrollsController.enrolls.forEach((key, value) {
                        codes.add(key);
                      });
                      return InkWell(
                          onTap: () {
                            enrollsController.enrollsByCode.value =
                                enrollsController.enrolls.value[codes[index]];
                            classController.classCode.value = codes[index];
                            Get.to(NavigationBarWidget());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.primaries[
                                    index % Colors.primaries.length]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      enrollsController
                                          .enrolls.value[codes[index]]['name'],
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0),
                                    ),
                                    Text(
                                      enrollsController.enrolls
                                          .value[codes[index]]['section'],
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Text(
                                      enrollsController.enrolls
                                          .value[codes[index]]['author'],
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 13.0),
                                    )
                                  ],
                                ),
                                IconButton(
                                    padding: EdgeInsets.all(0.0),
                                    onPressed: () {
                                      ShowBottom().showModalBottom(
                                          context,
                                          Wrap(
                                            children: [
                                              ListTile(
                                                title: Text('Edit'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  classController.classCode
                                                      .value = codes[index];
                                                  enrollsController
                                                          .enrollsByCode.value =
                                                      enrollsController.enrolls
                                                          .value[codes[index]];
                                                  Get.to(
                                                      () => UpdatedClassPage());
                                                },
                                              )
                                            ],
                                          ));
                                    },
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                      size: 25.0,
                                    )),
                              ],
                            ),
                          ));
                    }),
                  )));
        }));
  }
}
