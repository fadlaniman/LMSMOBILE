import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class StorageController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  final url = ''.obs;

  Future create(File image) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = await storageRef.child('images/${appStorage.path}');
      UploadTask uploadTask = file.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      url.value = await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future download(String fileUrl) async {
    await storageRef.child('images/${fileUrl}').getDownloadURL();
  }
}
