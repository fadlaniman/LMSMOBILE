import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class UsersController extends GetxController {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final userId = ''.obs;
  final userData = {}.obs;

  Future create(String firstName, String lastName, String email, String phone,
      String role) async {
    try {
      final snapshot = await ref.child('users/${userId.value}');
      await ref.set({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "role": role,
      });
    } on FirebaseAuth catch (e) {
      print(e);
    }
  }
}
