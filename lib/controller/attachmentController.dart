import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/classController.dart';
import 'package:mobile/controller/storageController.dart';

class AttachmentController extends GetxController {
  final storageController = Get.put(StorageController());
  final classController = Get.put(ClassController());
  final attachmment = {}.obs;
  final attachmmentById = {}.obs;
  final isLoading = true.obs;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future show() async {
    try {
      final data = await ref
          .child('/attachments/${classController.classCode.value}')
          .get();
      print(classController.classCode.value);
      if (data.exists) {
        attachmment.value = data.value as Map;
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future create(String code, String title, String description, int score,
      DateTime date, String type) async {
    try {
      await ref.child('attachments/$code').push().set({
        'title': title,
        'description': description,
        'file': storageController.url.value,
        'score': score,
        'date': date,
        'type': type,
      });
    } catch (e) {
      print(e);
    }
  }
}
