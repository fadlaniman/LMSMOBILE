import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/attachmentController.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/controller/storageController.dart';
import 'package:mobile/view/widgets/navigationBar.dart';
import 'package:mobile/view/widgets/showBottom.dart';
import 'package:mobile/view/widgets/textButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/view/widgets/title.dart';

class CreateAssignment extends StatefulWidget {
  const CreateAssignment({super.key});

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  late File _file;
  final scoreController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final storageController = Get.put(StorageController());
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.close)),
        title: Container(
            alignment: Alignment.centerRight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleWidget(),
                  Button(
                      title: 'Assign',
                      onPress: () async {
                        Get.to(() => NavigationBarWidget());
                      })
                ])),
      ),
      body: Container(
        child: Column(children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                hintText: 'Title',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0)),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
                hintText: 'Description',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0)),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: scoreController,
            decoration: InputDecoration(
                hintText: 'score',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0)),
          ),
          TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                ShowBottom().showModalBottom(
                    context,
                    Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.file_upload_outlined),
                          title: Text('Upload file'),
                          onTap: (() async {
                            FilePickerResult? picked =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf', 'doc', 'mp4'],
                            );
                            setState(() {
                              if (picked != null) {
                                _file = File(picked.files.first.name);
                              }
                            });
                          }),
                        ),
                        ListTile(
                          leading: Icon(Icons.image_outlined),
                          title: Text('Pick photo'),
                          onTap: (() async {
                            final picked = await picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              if (picked != null) {
                                _file = File(picked.path);
                              }
                            });
                            Navigator.of(context).pop();
                          }),
                        ),
                      ],
                    ));
              },
              child: Text('File'))
        ]),
      ),
    );
  }
}
