import 'dart:io';
import 'package:get/get.dart';
import 'package:mobile/controller/authController.dart';
import 'package:mobile/model/attachmentsModel.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/submissonModel.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../constants.dart';

class SubmissionController extends GetxController {
  final AuthController auth = Get.find();
  final attachments = <Submission>[].obs;
  final attachment = Rx<Attachments>(Attachments());
  final loading = true.obs;

  Future download(String filepath) async {
    try {
      final response = await http.get(
        Uri.parse('${Url.baseUrl}/api/download/$filepath'),
        headers: <String, String>{
          'Authorization': 'Bearer ${auth.box.read('token')}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        Directory? appDocumentsDirectory = await getExternalStorageDirectory();
        String filePath = '${appDocumentsDirectory!.path}/${filepath}';
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchById(String class_id, int attachment_id) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Url.baseUrl}/api/classes/$class_id/attachments/$attachment_id'),
        headers: <String, String>{
          'Authorization': 'Bearer ${auth.box.read('token')}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            jsonDecode(response.body)['data'];
        attachment.value = Attachments.fromJson(responseData);
        loading.value = false;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetch(
    String class_id,
    String attachment_id,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Url.baseUrl}/api/classes/$class_id/attachments/$attachment_id/submissions'),
        headers: <String, String>{
          'Authorization': 'Bearer ${auth.box.read('token')}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['data'];
        attachments.value = responseData.map((data) {
          return Submission.fromJson(data as Map<String, dynamic>);
        }).toList();
        loading.value = false;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future send(String class_id, String attachment_id, File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${Url.baseUrl}/api/classes/$class_id/attachments/$attachment_id/submissions'),
      );
      request.headers['Aputhorization'] = 'Bearer ${auth.box.read('token')}';
      request.fields['user_id'] = auth.user['uid'].toString();
      request.fields['class_id'] = class_id;
      request.fields['attachment_id'] = attachment_id;
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
      ));
      var response = await request.send();
      if (response.statusCode == 201) {
        return fetch(class_id, attachment_id);
      } else {
        throw Exception('Failed to send attachment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to send attachment: ${e}');
    }
  }
}
