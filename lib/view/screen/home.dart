import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/authController.dart';
import 'package:mobile/controller/classController.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/widgets/navigationBar.dart';
import 'package:mobile/view/widgets/title.dart';
import 'package:get/get.dart';
import 'package:mobile/view/widgets/navigationDrawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final enrollsController = Get.put(EnrollsController());
  final classController = Get.put(ClassController());
  final usersController = Get.put(UsersController());

  @override
  void initState() {
    enrollsController.showEnrolls();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TitleWidget(),
        ),
        drawer: NavigationDrawerWidget(),
        body: Obx(() {
          return enrollsController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: ListView.builder(
                      itemCount: enrollsController.enrolls.value.length,
                      scrollDirection: Axis.vertical,
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
                              print(classController.classCode.value);
                              Get.to(() => NavigationBarWidget());
                            },
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.primaries[
                                      index % Colors.primaries.length]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0),
                                  ),
                                  Text(
                                    '',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Text(
                                    '',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 13.0),
                                  )
                                ],
                              ),
                            ));
                      })));
        }));
  }
}
