import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/studiesModel.dart';
import 'dart:convert';

import 'package:mobile/view/admin/studies/fetch-studies.dart';

class StudiesController extends GetxController {
  final loading = true.obs;
  final studies = List<Studies>.empty().obs;

  Future<List<Studies>> fetch() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.84:8000/api/studies'));
      if (response.statusCode == 200) {
        loading.value = false;
        return studiesFromJson(response.body);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Studies>> send(
    int id,
    String name,
    String description,
    int duration,
  ) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.84:8000/api/studies'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'name': name,
        'description': description,
        'duration': duration,
      }),
    );
    if (response.statusCode == 201) {
      Get.to(() => const ReadStudiesPage());
      return studiesFromJson(response.body);
    } else {
      throw Exception(response.request);
    }
  }

  Future edit(
    String id,
    String name,
    String description,
    int duration,
  ) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.84:8000/api/users/${id}/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'name': name,
        'description': description,
        'duration': duration,
      }),
    );
    if (response.statusCode == 200) {}
  }

  Future delete(String id) async {
    final response = await http.post(
        Uri.parse('http://192.168.1.84:8000/api/studies/${id}/delete'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': id,
        }));
    if (response.statusCode == 200) {
      loading.value = true;
    } else {
      print(response.reasonPhrase);
    }
  }
}
