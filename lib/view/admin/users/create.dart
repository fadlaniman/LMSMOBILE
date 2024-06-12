import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/classController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/widgets/input.dart';
import 'package:mobile/view/widgets/textButton.dart';
import 'package:random_string/random_string.dart';

class CreateUsersPage extends StatefulWidget {
  const CreateUsersPage({super.key});

  @override
  State<CreateUsersPage> createState() => _CreateUsersPageState();
}

class _CreateUsersPageState extends State<CreateUsersPage> {
  final classController = Get.put(ClassController());
  final usersController = Get.put(UsersController());
  final uid = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final level = TextEditingController();
  final phone = TextEditingController();

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
                  Text('User'),
                  Button(
                      title: 'Create',
                      onPress: () {
                        usersController.create(
                          uid.text.trim(),
                          firstName.text.trim(),
                          lastName.text.trim(),
                          email.text.trim(),
                          password.text.trim(),
                          level.text.trim(),
                          phone.text.trim(),
                        );
                      }),
                ])),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Column(
            children: [
              InputWidget(
                keyboardType: TextInputType.text,
                controller: uid,
                title: 'UID',
              ),
              SizedBox(
                height: 10.0,
              ),
              InputWidget(
                keyboardType: TextInputType.text,
                controller: firstName,
                title: 'firstName',
              ),
              SizedBox(
                height: 10.0,
              ),
              InputWidget(
                keyboardType: TextInputType.text,
                controller: lastName,
                title: 'lastName',
              ),
              SizedBox(
                height: 10.0,
              ),
              InputWidget(
                keyboardType: TextInputType.text,
                controller: email,
                title: 'email',
              ),
              SizedBox(
                height: 10.0,
              ),
              InputWidget(
                keyboardType: TextInputType.text,
                controller: password,
                title: 'password',
              ),
              SizedBox(
                height: 10.0,
              ),
              InputWidget(
                keyboardType: TextInputType.text,
                controller: level,
                title: 'level',
              ),
              SizedBox(
                height: 10.0,
              ),
              InputWidget(
                keyboardType: TextInputType.text,
                controller: phone,
                title: 'phone',
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ));
  }
}
