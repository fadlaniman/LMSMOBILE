import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/authController.dart';
import 'package:get/get.dart';
import 'package:mobile/view/screen/forgotPassword.dart';

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
                      height: 15,
                    ),
                    Obx(() {
                      return authController.authenticate.value
                          ? Container()
                          : Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.red.shade700, width: 2),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.error, color: Colors.red.shade700),
                                  SizedBox(width: 8),
                                  Text('User not found',
                                      style: GoogleFonts.poppins(
                                          color: Colors.red.shade700,
                                          fontSize: 14.0)),
                                ],
                              ),
                            );
                    }),
                    SizedBox(
                      height: 15,
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
                    ListTile(
                      onTap: () => Get.to(() => const ForgotPassword()),
                      title: Text(
                        'Forgot Password?',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            color: Colors.blue.shade900),
                      ),
                    )
                  ],
                )))));
  }
}
