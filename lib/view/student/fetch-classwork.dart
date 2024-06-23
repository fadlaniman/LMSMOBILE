import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile/controller/attachmentController.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/student/fetch-assignment.dart';

class StudentClassWorkPage extends StatefulWidget {
  const StudentClassWorkPage({super.key});

  @override
  State<StudentClassWorkPage> createState() => _StudentClassWorkPageState();
}

class _StudentClassWorkPageState extends State<StudentClassWorkPage> {
  final attachmentsController = Get.put(AttachmentsController());

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
                          attachmentsController.fetchById(
                              attachmentsController
                                      .attachments[index].classId ??
                                  '',
                              attachmentsController.attachments[index].id ?? 0);
                          Get.to(() => const StudentAssignmentPage());
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
                                        fontSize: 14.0,
                                      ))),
                            ],
                          ),
                        ),
                      );
                    }));
          })),
    );
  }
}
