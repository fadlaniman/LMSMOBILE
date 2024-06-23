import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/classController.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/view/widgets/textButton.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({super.key});

  @override
  State<CreateClassPage> createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  final classController = Get.put(ClassController());
  final user_id = TextEditingController();
  final class_id = TextEditingController();

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
                  Text('Class'),
                  Button(
                    title: 'Create',
                    onPress: () {
                      classController.send(
                          user_id.text.trim(), class_id.text.trim());
                    },
                  )
                ])),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: user_id,
                  decoration: InputDecoration(
                    hintText: 'User',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: class_id,
                  decoration: InputDecoration(
                    hintText: 'Class',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
