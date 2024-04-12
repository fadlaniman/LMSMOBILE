import 'package:flutter/material.dart';
import 'package:mobile/controller/authenticationController.dart';
import 'package:get/get.dart';
import 'package:mobile/model/connection.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  void initState() {
    connection();
    super.initState();
  }

  final authentication = Get.put(AuthController());

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
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
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
                        controller: username,
                        decoration: InputDecoration(
                            hintText: 'username',
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
                            hintText: 'password',
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
                        authentication.login(
                            username: username.text.trim(),
                            password: password.text.trim());
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
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
