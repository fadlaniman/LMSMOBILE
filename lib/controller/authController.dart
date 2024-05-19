import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/admin/dashboard.dart';
import 'package:mobile/view/screen/login.dart';
import 'package:mobile/view/screen/home.dart';

class AuthController extends GetxController {
  final enrollsController = Get.put(EnrollsController());
  final usersController = Get.put(UsersController());
  final authMessage = ''.obs;

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      usersController.userId.value = credential.user!.uid;
      authMessage.value = '';
      final user =
          await ref.child('users/${credential.user!.uid}').once().then((value) {
        final data =
            usersController.userData.value = value.snapshot.value as Map;
        if (data['role'] == 'teacher' || data['role'] == 'student') {
          Get.to(() => Home());
        } else {
          Get.to(() => Dashboard());
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        authMessage.value = 'incorrect email format.';
      } else if (e.code == 'invalid-credential') {
        authMessage.value = 'user not found.';
      }
    }
  }

  Future register(String email, String password, String firstName,
      String lastName, String phone, String role) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      usersController.create(firstName, lastName, email, phone, role);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Failed', e.code,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    enrollsController.enrolls.clear();
    enrollsController.isLoading.value = true;
    Get.to(() => LoginPage());
  }
}
