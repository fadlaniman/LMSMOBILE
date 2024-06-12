import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/usersController.dart';

class ReadUsersPage extends StatefulWidget {
  const ReadUsersPage({super.key});

  @override
  State<ReadUsersPage> createState() => _ReadUsersPageState();
}

class _ReadUsersPageState extends State<ReadUsersPage> {
  UsersController usersController = Get.put(UsersController());

  @override
  void initState() {
    super.initState();
    usersController.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Users',
            style: GoogleFonts.poppins(),
          ),
        ),
        body: FutureBuilder(
          future: usersController.read(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('');
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ));
  }
}
