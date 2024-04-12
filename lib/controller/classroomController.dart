import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mobile/model/classroomModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ClassroomController extends GetxController {
  String authToken = GetStorage().read('token');
  final dataList = [].obs;
  final isLoading = true.obs;
  final classID = 0.obs;

  Future enrollClass({required String id}) async {
    try {
      final response = await http.post(
          Uri.parse('http://10.0.2.2:8000/api/classroom/store'),
          headers: {
            'Authorization': 'Bearer ${authToken}'
          },
          body: {
            "id": jsonEncode(int.tryParse(id)),
          });
      final data = jsonDecode(response.body)['message'];
      if (response.statusCode == 200) {
        isLoading.value = true;
        Get.back();
      } else {
        Get.snackbar('Failed', data,
            backgroundColor: Colors.red, colorText: Colors.white);
        isLoading.value = false;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future UnenrollClass({required int id}) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/classroom/delete'),
        headers: {'Authorization': 'Bearer ${authToken}'},
        body: {
          "id": jsonEncode(id),
        },
      );
      final data = jsonDecode(response.body)['message'];
      if (response.statusCode == 200) {
        isLoading.value = true;
      } else {
        Get.snackbar('Failed', data,
            backgroundColor: Colors.red, colorText: Colors.white);
        isLoading.value = false;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future showClass() async {
    try {
      final response = await http.get(
          Uri.parse('http://10.0.2.2:8000/api/classroom'),
          headers: {'Authorization': 'Bearer ${authToken}'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        dataList.value.add(Classroom.fromJson(data));
        isLoading.value = false;
      } else {
        isLoading.value = true;
        throw Exception('Failed to load Classroom');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
