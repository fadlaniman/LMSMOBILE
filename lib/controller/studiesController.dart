import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/studiesModel.dart';
import 'dart:convert';
import '../constants.dart';
import 'package:mobile/view/admin/studies/fetch-studies.dart';

class StudiesController extends GetxController {
  final studies = <Studies>[].obs;
  final study = Rx<Studies>(Studies());

  final loading = true.obs;

  Future fetchById(String id) async {
    try {
      final response =
          await http.get(Uri.parse('${Url.baseUrl}/api/studies/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            jsonDecode(response.body)['data'];
        study.value = Studies.fromJson(responseData);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetch() async {
    try {
      final response = await http.get(Uri.parse('${Url.baseUrl}/api/studies'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        studies.value = responseData.map((data) {
          return Studies.fromJson(data as Map<String, dynamic>);
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
    String id,
    String name,
    String description,
    int duration,
  ) async {
    final response = await http.post(
      Uri.parse('${Url.baseUrl}/api/studies'),
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
      Get.to(() => const FetchStudiesPage());
      return fetch();
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future edit(
    String id,
    String name,
    String description,
    int duration,
  ) async {
    final response = await http.post(
      Uri.parse('${Url.baseUrl}/api/studies/${id}/update'),
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
    if (response.statusCode == 200) {
      Get.to(() => const FetchStudiesPage());
      return fetch();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future delete(String id) async {
    final response = await http.post(
      Uri.parse('${Url.baseUrl}/api/studies/${id}/delete'),
      headers: <String, String>{
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
