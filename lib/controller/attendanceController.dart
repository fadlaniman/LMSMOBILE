import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/authController.dart';
import 'package:mobile/model/attendanceModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../constants.dart';

class AttendanceController extends GetxController {
  final AuthController auth = Get.find();
  final attendances = <Attendance>[].obs;
  final loading = true.obs;

  Future fetch(id) async {
    try {
      final response = await http.get(
        Uri.parse('${Url.baseUrl}/api/classes/$id/attendances'),
        headers: <String, String>{
          'Authorization': 'Bearer ${auth.box.read('token')}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['data'];
        attendances.value = responseData.map((data) {
          return Attendance.fromJson(data as Map<String, dynamic>);
        }).toList();
        loading.value = false;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future send(id, DateTime dateTime) async {
    try {
      final response = await http.post(
        Uri.parse('${Url.baseUrl}/api/classes/$id/attendances'),
        headers: <String, String>{
          'Authorization': 'Bearer ${auth.box.read('token')}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'datetime': DateFormat('yyyy-MM-dd').format(dateTime),
          'class_id': id,
        }),
      );
      if (response.statusCode == 201) {
        return fetch(id);
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
