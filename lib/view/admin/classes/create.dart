import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/classController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/widgets/input.dart';
import 'package:mobile/view/widgets/textButton.dart';
import 'package:random_string/random_string.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({super.key});

  @override
  State<CreateClassPage> createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  final classController = Get.put(ClassController());
  final usersController = Get.put(UsersController());
  final name = TextEditingController();
  final section = TextEditingController();
  final subject = TextEditingController();

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
                  Text('Create class'),
                  Button(
                      title: 'Create class',
                      onPress: () {
                        final author =
                            usersController.userData.value['firstName'] +
                                ' ' +
                                usersController.userData.value['lastName'];
                        classController.createClass(
                          randomAlphaNumeric(8),
                          author,
                          name.text.trim(),
                          section.text.trim(),
                          subject.text.trim(),
                        );
                      }),
                ])),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Column(
            children: [
              InputWidget(
                keyboardType: TextInputType.text,
                controller: name,
                title: 'Class name',
              ),
              SizedBox(
                height: 30.0,
              ),
              InputWidget(
                  keyboardType: TextInputType.text,
                  controller: section,
                  title: 'Section'),
              SizedBox(
                height: 30.0,
              ),
              InputWidget(
                  keyboardType: TextInputType.text,
                  controller: subject,
                  title: 'Subject')
            ],
          ),
        ));
  }
}
