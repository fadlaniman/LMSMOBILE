import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/admin/dashboard.dart';
import 'package:mobile/view/screen/login.dart';
import 'package:mobile/view/screen/home.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final enrollsController = Get.put(EnrollsController());
  final usersController = Get.put(UsersController());
  final username = ''.obs;
  final authenticate = true.obs;

  Future login(String email, String password) async {
    try {
      final response =
          await http.post(Uri.parse('http://192.168.1.84:8000/api/login'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'email': email,
                'password': password,
              }));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        username.value = data['data']['firstName'];
        if (data['data']['level'] == '1') {
          Get.to(() => Dashboard());
        } else if (data['data']['level'] == '2') {
          Get.to(() => Home());
        } else if (data['data']['level'] == '3') {
          Get.to(() => Home());
        }
      } else {
        authenticate.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    authenticate.value = true;
    Get.to(() => LoginPage());
  }
}
