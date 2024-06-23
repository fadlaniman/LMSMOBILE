import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/screen/splash.dart';
import 'view/screen/login.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

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
                    style: GoogleFonts.poppins(
                        fontSize: 25.0, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Untuk akses fitur aplikasi dengan mudah!',
                    style: GoogleFonts.poppins(fontSize: 16.0),
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
                              MaterialStatePropertyAll<Color>(primaryColor),
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      label: Text('Masuk',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                      icon: const Icon(Icons.arrow_right_alt)),
                ])));
  }
}
