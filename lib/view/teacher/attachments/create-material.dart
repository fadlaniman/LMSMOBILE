import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/attachmentController.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/view/widgets/showBottom.dart';
import 'package:mobile/view/widgets/textButton.dart';
import 'package:image_picker/image_picker.dart';

class CreateMaterial extends StatefulWidget {
  const CreateMaterial({super.key});

  @override
  State<CreateMaterial> createState() => _CreateMaterialState();
}

class _CreateMaterialState extends State<CreateMaterial> {
  final attachmentsController = Get.put(AttachmentsController());
  final studiesController = Get.put(StudiesController());

  File? _files;
  final _title = TextEditingController();
  final _description = TextEditingController();
  final picker = ImagePicker();
  final _file = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.close)),
        title: Container(
            alignment: Alignment.centerRight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Title(
                      color: Colors.black,
                      child: Text(
                        'Material',
                        style: GoogleFonts.poppins(),
                      )),
                  Button(
                      title: 'Post',
                      onPress: () {
                        attachmentsController.send(
                            _title.text.trim(),
                            _description.text.trim(),
                            'material',
                            DateTime.now(),
                            _files!,
                            studiesController.study.value.id ?? '');
                      })
                ])),
      ),
      body: Container(
        child: Column(children: <Widget>[
          TextField(
            controller: _title,
            decoration: InputDecoration(
                hintText: 'Title',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0)),
          ),
          TextField(
            controller: _description,
            decoration: InputDecoration(
                hintText: 'Description',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0)),
          ),
          TextFormField(
            readOnly: true,
            controller: _file,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
              hintText: _file.text.isEmpty ? 'File' : _file.text,
              border: OutlineInputBorder(),
            ),
            onTap: () {
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
                            allowedExtensions: ['ppt', 'pdf', 'doc', 'mp4'],
                          );
                          setState(() {
                            if (picked != null) {
                              _files = File(picked.files.first.path ?? '');
                              _file.text = picked.files.first.name;
                            }
                          });
                          Navigator.of(context).pop();
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
                              _files = File(picked.path);
                              _file.text = picked.name;
                            }
                          });
                          Navigator.of(context).pop();
                        }),
                      ),
                    ],
                  ));
              ;
            },
          ),
        ]),
      ),
    );
  }
}
