import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/usersModel.dart';
import 'dart:convert';
import 'package:mobile/view/admin/dashboard.dart';

class UsersController extends GetxController {
  final userId = ''.obs;
  final userData = {}.obs;
  final loading = false.obs;
  final data = <Users>[].obs;

  Future<void> read() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/users'));
    if (response.statusCode == 200) {
      loading.value = true;
      final List<Users> usersList =
          usersFromJson(response.body); // Convert response body to List<Users>
      data.assignAll(usersList); // Assign the list to the data
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future create(
    String uid,
    String firstName,
    String lastName,
    String email,
    String password,
    String level,
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/users'),
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
      Get.to(() => Dashboard());
    }
  }

  Future edit(String uid, String firstName, String lastName, String email,
      String password, String phone, String level) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/users/${uid}/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uid': uid,
        'firstname': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'level': level,
        'phone': phone,
      }),
    );
    if (response.statusCode == 200) {}
  }

  Future delete(String uid) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/users/${uid}/delete'),
    );
  }
}
