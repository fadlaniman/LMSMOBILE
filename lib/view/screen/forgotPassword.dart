import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/usersController.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _uid = TextEditingController();
  final usersController = Get.put(UsersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            title: Text('Enter Your UID',
                textAlign: TextAlign.right,
                style: GoogleFonts.poppins(fontSize: 14.0)),
            subtitle: TextFormField(
              readOnly: true,
              controller: _uid,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                hintText: 'UID',
                border: OutlineInputBorder(),
              ),
            ),
          )),
    ));
  }
}
