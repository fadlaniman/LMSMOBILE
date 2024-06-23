import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/widgets/textButton.dart';

class UpdateStudiesPage extends StatefulWidget {
  const UpdateStudiesPage({super.key});

  @override
  State<UpdateStudiesPage> createState() => _UpdateStudiesPageState();
}

class _UpdateStudiesPageState extends State<UpdateStudiesPage> {
  final StudiesController studiesController = Get.find();
  final _id = TextEditingController();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _duration = TextEditingController();
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close)),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Studies',
                    style: GoogleFonts.poppins(),
                  ),
                  Button(title: 'Update', onPress: () {}),
                ])),
        body: SingleChildScrollView(
          child: Obx(() {
            _id.text = studiesController.study.value.id.toString();
            _name.text = studiesController.study.value.name ?? '';
            _description.text = studiesController.study.value.description ?? '';
            _duration.text = studiesController.study.value.duration.toString();
            return Container(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _id,
                    decoration: InputDecoration(
                      hintText: 'ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: _description,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || value.length > 1) {
                        setState(() {
                          isValid = true;
                        });
                      }
                    },
                    controller: _duration,
                    decoration: InputDecoration(
                      hintText: 'Duration',
                      errorText: isValid ? 'only one number' : null,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
