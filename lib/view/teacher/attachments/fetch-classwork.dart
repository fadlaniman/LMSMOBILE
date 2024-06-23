import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile/controller/attachmentController.dart';
import 'package:mobile/controller/commentsController.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/teacher/attachments/create-assignment.dart';
import 'package:mobile/view/teacher/attachments/create-material.dart';
import 'package:mobile/view/teacher/attachments/fetch-assignment.dart';
import 'package:mobile/view/widgets/floatingButtonBottom.dart';
import 'package:mobile/view/widgets/showBottom.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:io';

class TeacherClassWorkPage extends StatefulWidget {
  const TeacherClassWorkPage({super.key});

  @override
  State<TeacherClassWorkPage> createState() => _TeacherClassWorkPageState();
}

class _TeacherClassWorkPageState extends State<TeacherClassWorkPage> {
  final attachmentsController = Get.put(AttachmentsController());
  final commentsController = Get.put(CommentsController());
  bool? isError;
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.0,
          ),
          child: Obx(() {
            return attachmentsController.loading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: attachmentsController.attachments.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          commentsController.fetch(
                              attachmentsController
                                      .attachments[index].classId ??
                                  '',
                              attachmentsController.attachments[index].id ?? 0);
                          attachmentsController.fetchById(
                              attachmentsController
                                      .attachments[index].classId ??
                                  '',
                              attachmentsController.attachments[index].id ?? 0);
                          Get.to(() => const TeacherAssignmentPage());
                        },
                        child: Container(
                          margin: EdgeInsets.all(5.0),
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
                                        color: attachmentsController
                                                    .attachments[index].type ==
                                                'assignment'
                                            ? primaryColor
                                            : Colors.yellow[800],
                                        shape: BoxShape.circle,
                                      ),
                                      child: attachmentsController
                                                  .attachments[index].type ==
                                              'assignment'
                                          ? Icon(
                                              Icons.assignment_outlined,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.book_outlined,
                                              color: Colors.white,
                                            )),
                                  title: Text(
                                    attachmentsController
                                            .attachments[index].title ??
                                        '',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                      '${DateFormat('d MMMM').format(attachmentsController.attachments[index].createdAt ?? DateTime.now())}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.0,
                                      ))),
                            ],
                          ),
                        ),
                      );
                    }));
          })),
      floatingActionButton: FloatingButtonWidget(
        color: Colors.white,
        backgroundColor: primaryColor,
        onPress: () {
          ShowBottom().showModalBottom(
              context,
              Wrap(
                children: [
                  ListTile(
                    title: Text(
                      'Create',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  ListTile(
                    title: Text('Assignment'),
                    leading: Icon(Icons.assignment_outlined),
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => const CreateAssignment());
                    },
                  ),
                  ListTile(
                    title: Text('Material'),
                    leading: Icon(Icons.class_outlined),
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => const CreateMaterial());
                    },
                  )
                ],
              ));
        },
      ),
    );
  }
}
