import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/authController.dart';

class TitleWidget extends StatelessWidget {
  TitleWidget({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Text(
      '${authController.user['firstName']}',
      style: GoogleFonts.poppins(),
    );
  }
}
