import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/usersModel.dart';
import 'dart:convert';
import 'package:mobile/view/admin/users/fetch-users.dart';

class UsersController extends GetxController {
  final userId = ''.obs;
  final userData = {}.obs;
  final loading = true.obs;
  final users = List<Users>.empty().obs;
  final user = {}.obs;

  Future fetchById(String uid) async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.84:8000/api/users/$uid'));
      if (response.statusCode == 200) {
        user.value = jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Users>> fetch() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.84:8000/api/users'));
      if (response.statusCode == 200) {
        loading.value = false;
        return usersFromJson(response.body);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Users>> send(
    String uid,
    String firstName,
    String lastName,
    String email,
    String password,
    String level,
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.84:8000/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'level': level,
        'phone': phone,
      }),
    );
    if (response.statusCode == 201) {
      Get.to(() => const ReadUsersPage());
      return usersFromJson(response.body);
    } else {
      throw Exception(response.request);
    }
  }

  Future<List<Users>> edit(String uid, String firstName, String lastName,
      String email, String password, String level, String phone) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.84:8000/api/users/$uid/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'level': level,
        'phone': phone,
      }),
    );
    if (response.statusCode == 200) {
      Get.to(() => const ReadUsersPage());
      return usersFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<Users>> delete(int uid) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.84:8000/api/users/$uid/delete'),
    );
    if (response.statusCode == 200) {
      return users;
    } else {
      throw Exception('err');
    }
  }
}
