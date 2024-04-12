import 'package:flutter/material.dart';
import 'package:mobile/view/screen/splash.dart';
import 'view/screen/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage().read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});
  final color = const Color.fromRGBO(210, 35, 19, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Masuk',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Untuk akses fitur aplikasi dengan mudah!',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Get.offAll(() => LoginPage());
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(color),
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      label: const Text(
                        'Masuk',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      icon: const Icon(Icons.arrow_right_alt)),
                ])));
  }
}
