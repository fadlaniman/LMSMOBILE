import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/authController.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';
import 'package:mobile/model/userAttendanceModel.dart';

class UserAttendanceController extends GetxController {
  final AuthController auth = Get.find();
  final userAttendances = <UserAttendance>[].obs;
  final loading = true.obs;

  Future fetch(String class_id, int attendance_id) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Url.baseUrl}/api/classes/$class_id/userAttendances/$attendance_id'),
        headers: <String, String>{
          'Authorization': 'Bearer ${auth.box.read('token')}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['data'];
        userAttendances.value = responseData.map((data) {
          return UserAttendance.fromJson(data as Map<String, dynamic>);
        }).toList();
        loading.value = false;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future send(
    int attendance_id,
    int user_id,
    String class_id,
  ) async {
    final response = await http.post(
      Uri.parse(
          '${Url.baseUrl}/api/classes/$class_id/userAttendances/$attendance_id'),
      headers: <String, String>{
        'Authorization': 'Bearer ${auth.box.read('token')}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'attendance_id': attendance_id,
        'user_id': user_id,
        'class_id': class_id,
      }),
    );
    if (response.statusCode == 201) {
      Get.snackbar('Success', 'Your attendance has been record',
          backgroundColor: Colors.green, colorText: Colors.white);
      return fetch(class_id, attendance_id);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
