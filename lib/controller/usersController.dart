import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/usersModel.dart';
import 'dart:convert';
import 'package:mobile/view/admin/users/fetch-users.dart';
import '../constants.dart';

class UsersController extends GetxController {
  final userId = ''.obs;
  final userData = {}.obs;
  final loading = true.obs;
  final users = <Users>[].obs;
  final user = Rx<Users>(Users());

  Future fetchById(int uid) async {
    try {
      final response =
          await http.get(Uri.parse('${Url.baseUrl}/api/users/$uid'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            jsonDecode(response.body)['data'];
        user.value = Users.fromJson(responseData);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetch() async {
    try {
      final response = await http.get(Uri.parse('${Url.baseUrl}/api/users'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['data'];
        users.value = responseData.map((data) {
          return Users.fromJson(data as Map<String, dynamic>);
        }).toList();
        loading.value = false;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      loading.value = false;
    }
  }

  Future send(
    String uid,
    String firstName,
    String lastName,
    String email,
    String password,
    String level,
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse('${Url.baseUrl}/api/users'),
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
      Get.to(() => const FetchUsersPage());
      return fetch();
    } else {
      throw Exception(response.request);
    }
  }

  Future edit(String uid, String firstName, String lastName, String email,
      String password, String level, String phone) async {
    final response = await http.post(
      Uri.parse('${Url.baseUrl}/api/users/$uid/update'),
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
    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      Get.to(() => const FetchUsersPage());
      return fetch();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future delete(int uid) async {
    final response = await http.post(
      Uri.parse('${Url.baseUrl}/api/users/$uid/delete'),
    );
    if (response.statusCode == 200) {
      return fetch();
    } else {
      throw Exception('err');
    }
  }
}
