import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/admin/dashboard.dart';
import 'package:mobile/view/screen/login.dart';
import 'package:mobile/view/screen/home.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final enrollsController = Get.put(EnrollsController());
  final usersController = Get.put(UsersController());
  final username = ''.obs;
  final authenticate = true.obs;

  Future login(String email, String password) async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8000/api/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': email,
              'password': password,
            }));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      authenticate.value = true;
      username.value = data['data']['firstName'];
      if (data['data']['level'] == '1') {
        Get.to(() => Dashboard());
      } else if (data['data']['level'] == '2') {
        Get.to(() => Home());
      } else if (data['data']['level'] == '3') {
        Get.to(() => Home());
      }
    }
    authenticate.value = false;
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    enrollsController.enrolls.clear();
    enrollsController.isLoading.value = true;
    Get.to(() => LoginPage());
  }
}
