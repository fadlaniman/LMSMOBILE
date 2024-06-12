import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/attachmentController.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/widgets/title.dart';

class AssignmentByCode extends StatefulWidget {
  const AssignmentByCode({super.key});

  @override
  State<AssignmentByCode> createState() => _AssignmentByCodeState();
}

class _AssignmentByCodeState extends State<AssignmentByCode> {
  final attachmentController = Get.put(AttachmentController());
  final enrollsController = Get.put(EnrollsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: primaryColor,
                ))),
                child: ListTile(
                  contentPadding: EdgeInsetsDirectional.all(5.0),
                  title: Text(
                    attachmentController.attachmmentById.value['title'],
                    style: GoogleFonts.poppins(
                        color: primaryColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                      '${enrollsController.enrollsByCode.value['author']}',
                      style: GoogleFonts.poppins(fontSize: 13.0)),
                )),
            Container(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
