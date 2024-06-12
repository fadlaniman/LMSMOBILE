import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/screen/home.dart';

class EnrollsController extends GetxController {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final user = Get.put(UsersController());
  final enrolls = {}.obs;
  final enrollsByCode = {}.obs;
  final isLoading = true.obs;

  Future showEnrolls() async {
    final classes = await ref.child('class');
    final userClass = await ref.child('user_class');
    final userClassLength = await userClass.child(user.userId.value).once();
    try {
      if (!userClassLength.snapshot.exists) {
        isLoading.value = false;
      }
      userClass.child(user.userId.value).onChildAdded.listen((event) async {
        classes.child(event.snapshot.key as String).once().then((dataSnapshot) {
          enrolls.value
              .addAll({dataSnapshot.snapshot.key: dataSnapshot.snapshot.value});
          if (enrolls.value.length ==
              userClassLength.snapshot.children.length) {
            isLoading.value = false;
          }
        });
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future joinClass(String code) async {
    final classes = await ref.child('class/${code}').once();
    // final conn = await connection;
    try {
      if (classes.snapshot.exists) {
        await ref.child('user_class/${user.userId.value}').update({code: true});
        await ref
            .child('class/${code}/members')
            .update({user.userId.value: true});
        enrolls.value.clear();
        isLoading.value = true;
        showEnrolls();
        Get.to(() => Home());
      } else {
        Get.snackbar('Failed', 'Class not found',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } on FirebaseAuthException catch (e) {}
  }

  Future outClass(String code) async {
    // final conn = await connection;
    try {
      await ref.child('user_class/${user.userId.value}/${code}').remove();
      // await conn.query('delete from user_class where class_id=?', [code]);
      enrolls.value.clear();
      isLoading.value = true;
      showEnrolls();
    } on FirebaseAuthException catch (e) {}
  }
}
