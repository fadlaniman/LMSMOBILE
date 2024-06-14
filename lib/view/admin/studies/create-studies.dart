import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/widgets/input.dart';
import 'package:mobile/view/widgets/textButton.dart';
import 'package:random_string/random_string.dart';

class CreateStudiesPage extends StatefulWidget {
  const CreateStudiesPage({super.key});

  @override
  State<CreateStudiesPage> createState() => _CreateStudiesPageState();
}

class _CreateStudiesPageState extends State<CreateStudiesPage> {
  final usersController = Get.put(UsersController());
  dynamic _duration;
  final id = TextEditingController();
  final name = TextEditingController();
  final desctiprion = TextEditingController();
  final duration = TextEditingController();

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
                  Text('Studies'),
                  Button(title: 'Create', onPress: () {}),
                ])),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: id,
                  decoration: InputDecoration(
                    hintText: 'UID',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: desctiprion,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ));
  }
}
