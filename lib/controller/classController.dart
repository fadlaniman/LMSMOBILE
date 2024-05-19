import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/controller/enrollsController.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/admin/dashboard.dart';
import 'package:mobile/view/screen/home.dart';

class ClassController extends GetxController {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final enrollsController = Get.put(EnrollsController());
  final usersController = Get.put(UsersController());
  final classCode = ''.obs;

  Future createClass(
    String code,
    String author,
    String name,
    String section,
    String subject,
  ) async {
    try {
      await ref.child('class/$code').set({
        "name": name,
        "section": section,
        "subject": subject,
        "author": author,
      });
      Get.to(() => Dashboard());
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future updateClass(
    String code,
    String name,
    String section,
    String subject,
  ) async {
    try {
      await ref.child('class/$code').update({
        'name': name,
        'section': section,
        'subject': subject,
      });

      enrollsController.enrolls.clear();
      enrollsController.isLoading.value = true;
      enrollsController.showEnrolls();
    } on FirebaseAuthException catch (e) {}
  }
}
