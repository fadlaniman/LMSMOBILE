import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/controller/classroomController.dart';
import 'package:mobile/view/student/studies.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/view/teacher/dashboard.dart';

class ClassesController extends GetxController {
  String authToken = GetStorage().read('token');
  final classesRoom = Get.put(ClassroomController());

  Future showClass({required int id}) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/classes/show/${id}'),
        headers: {'Authorization': 'Bearer ${authToken}'},
      );
      if (response.statusCode == 200) {
        Get.to(() => Studies());
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future createClass(
      {required String name,
      required String section,
      required String subject}) async {
    final body = {
      'name': name,
      'section': section,
      'subject': subject,
    };
    try {
      final response = await http.post(
          Uri.parse('http://10.0.2.2:8000/api/classes/store'),
          headers: {'Authorization': 'Bearer ${authToken}'},
          body: body);
      if (response.statusCode == 201) {
        classesRoom.dataList.clear();
        classesRoom.isLoading.value = true;
        Get.to(() => DashboardTeacher());
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future updateClass(
      {required int id,
      required String name,
      required String section,
      required String subject}) async {
    final body = {
      'name': name,
      'section': section,
      'subject': subject,
    };
    try {
      final response = await http.post(
          Uri.parse('http://10.0.2.2:8000/api/classes/updated/${id}'),
          headers: {'Authorization': 'Bearer ${authToken}'},
          body: body);
      if (response.statusCode == 201) {
        classesRoom.dataList.clear();
        classesRoom.isLoading.value = true;
        Get.to(() => DashboardTeacher());
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
