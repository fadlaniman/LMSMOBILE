import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/controller/authController.dart';
import 'package:mobile/model/classModel.dart';
import 'dart:convert';
import '../constants.dart';

class ClassController extends GetxController {
  final classes = <Class>[].obs;
  final loading = true.obs;
  final AuthController auth = Get.find();

  Future fetch() async {
    try {
      final response = await http.get(
        Uri.parse('${Url.baseUrl}/api/classes'),
        headers: <String, String>{
          'Authorization': 'Bearer ${auth.box.read('token')}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['data'];
        classes.value = responseData.map((data) {
          return Class.fromJson(data as Map<String, dynamic>);
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
    String user_id,
    String class_id,
  ) async {
    final response = await http.post(
      Uri.parse('${Url.baseUrl}/api/classes'),
      headers: <String, String>{
        'Authorization': 'Bearer ${auth.box.read('token')}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': user_id,
        'class_id': class_id,
      }),
    );
    if (response.statusCode == 201) {
      return fetch();
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future delete(int id) async {
    final response = await http.post(
      Uri.parse('${Url.baseUrl}/api/classes/${id}/delete'),
      headers: <String, String>{
        'Authorization': 'Bearer ${auth.box.read('token')}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return fetch();
    } else {
      print(response.reasonPhrase);
    }
  }
}
