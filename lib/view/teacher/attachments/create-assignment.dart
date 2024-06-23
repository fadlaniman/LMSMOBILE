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
import 'package:intl/intl.dart';

class CreateAssignment extends StatefulWidget {
  const CreateAssignment({super.key});

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  final attachmentsController = Get.put(AttachmentsController());
  final studiesController = Get.put(StudiesController());
  File? _files;
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _deadline = TextEditingController();
  final _dateFormat = DateFormat('EEEE, d MMMM yyyy HH:mm:ss');
  final _file = TextEditingController();
  final picker = ImagePicker();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _deadline.text = _dateFormat.format(pickedDate);
      });
    }
  }

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
                  Title(
                      color: Colors.black,
                      child: Text(
                        'Assignment',
                        style: GoogleFonts.poppins(),
                      )),
                  Button(
                      title: 'Post',
                      onPress: () async {
                        attachmentsController.send(
                            _title.text.trim(),
                            _description.text.trim(),
                            'assignment',
                            _dateFormat.parse(_deadline.text),
                            _files!,
                            studiesController.study.value.id ?? '');
                      })
                ])),
      ),
      body: Container(
        child: Column(children: [
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
            controller: _deadline,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
              hintText: 'Deadline',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () => _selectDate(context),
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
                            allowedExtensions: ['pdf', 'doc', 'mp4'],
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
