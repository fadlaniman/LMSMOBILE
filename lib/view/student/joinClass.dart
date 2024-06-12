import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/widgets/textButton.dart';
import 'package:mobile/view/widgets/title.dart';

class JoinClassPage extends StatefulWidget {
  const JoinClassPage({super.key});

  @override
  State<JoinClassPage> createState() => _JoinClassPageState();
}

class _JoinClassPageState extends State<JoinClassPage> {
  final enrollsController = Get.put(EnrollsController());
  final usersController = Get.put(UsersController());
  final classCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close)),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TitleWidget(),
            Button(
              title: 'Join',
              onPress: () {
                enrollsController.joinClass(classCode.text.trim());
              },
            )
          ])),
      body: Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You're currently signed as",
                    style: GoogleFonts.poppins(
                        fontSize: 14.0, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    usersController.userData.value['email'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  )
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Ask you teacher for the class ID, then enter it here.',
                style: GoogleFonts.poppins(fontSize: 14.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: TextField(
                  controller: classCode,
                  decoration: InputDecoration(
                    labelText: 'Classes code',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
