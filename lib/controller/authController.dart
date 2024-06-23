import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/admin/dashboard.dart';
import 'package:mobile/view/screen/login.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/view/student/home.dart';
import 'package:mobile/view/teacher/home.dart';
import '../constants.dart';

class AuthController extends GetxController {
  final usersController = Get.put(UsersController());
  final user = {}.obs;
  final authenticate = true.obs;
  final box = GetStorage();

  Future login(String email, String password) async {
    try {
      final response = await http.post(Uri.parse('${Url.baseUrl}/api/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password,
          }));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        user.value = data['data'];
        box.write('token', data['token']);
        if (data['data']['level'] == '1') {
          Get.to(() => const Dashboard());
        } else if (data['data']['level'] == '2') {
          Get.to(() => const HomeTeacherPage());
        } else if (data['data']['level'] == '3') {
          Get.to(() => const HomeStudentPage());
        }
      } else {
        authenticate.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future forgotPassword(String password) async {
    try {
      final response =
          await http.post(Uri.parse('${Url.baseUrl}/forgotPassword'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'password': password,
              }));
      if (response.statusCode == 200) {
        print('success');
      } else {
        authenticate.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future logout() async {
    final response = await http.post(
      Uri.parse('${Url.baseUrl}/api/logout'),
      headers: <String, String>{
        'Authorization': 'Bearer ${box.read('token')}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      box.remove('token');
      authenticate.value = true;
      Get.to(() => LoginPage());
    }
  }
}
