import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/classroomController.dart';

class Header extends StatelessWidget {
  Header({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(title),
    );
  }
}
