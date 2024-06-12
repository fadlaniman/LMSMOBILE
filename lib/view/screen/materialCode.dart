import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/attachmentController.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/controller/storageController.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/widgets/title.dart';

class MaterialByCode extends StatefulWidget {
  const MaterialByCode({super.key});

  @override
  State<MaterialByCode> createState() => _MaterialByCodeState();
}

class _MaterialByCodeState extends State<MaterialByCode> {
  final attachmentController = Get.put(AttachmentController());
  final enrollsController = Get.put(EnrollsController());
  final storageController = Get.put(StorageController());

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
            InkWell(
              onTap: () {
                storageController
                    .download(attachmentController.attachmmentById['file']);
              },
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade400)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                        leading: Image.network(
                          attachmentController.attachmmentById['file'],
                        ),
                        title: Text(
                          attachmentController.attachmmentById['title'],
                          style: GoogleFonts.poppins(
                              fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                            attachmentController.attachmmentById['description'],
                            style: GoogleFonts.poppins(fontSize: 13.0))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
