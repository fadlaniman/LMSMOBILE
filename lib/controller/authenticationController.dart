import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:mobile/model/connection.dart';
import 'package:mobile/view/student/dashboard.dart';
import 'package:mobile/view/teacher/dashboard.dart';

class AuthController extends GetxController {
  final box = GetStorage();

  Future login({required String username, required String password}) async {
    final body = {
      'username': username,
      'password': password,
    };
    try {
      final response = await http
          .post(Uri.parse('http://10.0.2.2:8000/api/login'), body: body);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (data['data']['role'] == 'student') {
          box.write('token', data['token']);
          Get.to(() => DashboardStudent());
        } else if (data['data']['role'] == 'teacher') {
          box.write('token', data['token']);
          Get.to(() => DashboardTeacher());
        }
      } else {
        Get.snackbar(
          'Error',
          data['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
