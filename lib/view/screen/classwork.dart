import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/attachmentController.dart';
import 'package:mobile/controller/classController.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/screen/assignmentCode.dart';
import 'package:mobile/view/screen/materialCode.dart';

class ClassWorkPage extends StatefulWidget {
  const ClassWorkPage({super.key});

  @override
  State<ClassWorkPage> createState() => _ClassWorkPageState();
}

class _ClassWorkPageState extends State<ClassWorkPage> {
  final attachmentController = Get.put(AttachmentController());
  final classController = Get.put(ClassController());

  @override
  void initState() {
    super.initState();
    attachmentController.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return attachmentController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: ListView.builder(
                    itemCount: attachmentController.attachmment.value.length,
                    itemBuilder: ((context, index) {
                      List code = [];
                      attachmentController.attachmment.value
                          .forEach((key, value) {
                        code.add(key);
                      });
                      return InkWell(
                        onTap: () {
                          attachmentController.attachmmentById.value =
                              attachmentController
                                  .attachmment.value[code[index]];
                          attachmentController.attachmment.value[code[index]]
                                      ['type'] ==
                                  'material'
                              ? Get.to(() => MaterialByCode())
                              : Get.to(() => AssignmentByCode());
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey.shade400)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                  leading: Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      attachmentController.attachmment
                                                  .value[code[index]]['type'] ==
                                              'material'
                                          ? Icons.class_outlined
                                          : Icons.assignment_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(
                                    attachmentController.attachmment
                                        .value[code[index]]['title'],
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                      attachmentController.attachmment
                                          .value[code[index]]['date'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.0,
                                      ))),
                            ],
                          ),
                        ),
                      );
                    })),
              );
      }),
    );
  }
}
