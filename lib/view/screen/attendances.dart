import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/view/widgets/title.dart';
import 'package:mobile/view/widgets/navigationDrawer.dart';

class AttendancesPage extends StatefulWidget {
  const AttendancesPage({super.key});

  @override
  State<AttendancesPage> createState() => _AttendancesPageState();
}

class _AttendancesPageState extends State<AttendancesPage> {
  final enrollsController = Get.put(EnrollsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(''),
    );
  }
}
