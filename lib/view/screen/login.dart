import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/authController.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          fontSize: 26.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Obx(() {
                      return authController.authMessage.value != ''
                          ? Container(
                              width: 200,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 30.0),
                              child: Text(
                                authController.authMessage.value,
                                style: GoogleFonts.poppins(fontSize: 12.0),
                                textAlign: TextAlign.center,
                              ),
                              decoration:
                                  BoxDecoration(color: Colors.red.shade200),
                            )
                          : const Center();
                    }),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(1, 2)),
                          ]),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 15.0),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(1, 2)),
                          ]),
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 15.0),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        authController.login(
                            email.text.trim(), password.text.trim());
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                            fontSize: 15.0, fontWeight: FontWeight.w600),
                      ),
                      style: ButtonStyle(
                          minimumSize: MaterialStatePropertyAll<Size>(
                              Size(double.infinity, 50)),
                          shape:
                              MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 218, 33, 16)),
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                    ),
                  ],
                )))));
  }
}
