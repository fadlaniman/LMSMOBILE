import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/model/usersModel.dart';
import 'package:mobile/view/widgets/input.dart';
import 'package:mobile/view/widgets/textButton.dart';

class UpdateUsersPage extends StatefulWidget {
  const UpdateUsersPage({super.key});

  @override
  State<UpdateUsersPage> createState() => _UpdateUsersPageState();
}

class _UpdateUsersPageState extends State<UpdateUsersPage> {
  UsersController usersController = Get.put(UsersController());

  dynamic _level;
  final _uid = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();

  @override
  void initState() {
    _uid.text = usersController.user['uid'].toString();
    _firstName.text = usersController.user['firstName'];
    _lastName.text = usersController.user['lastName'];
    _email.text = usersController.user['email'];
    _level = usersController.user['level'];
    _phone.text = usersController.user['phone'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close)),
            title: Obx(() {
              return usersController.loading.value
                  ? Text(
                      'Loading...',
                      style: GoogleFonts.poppins(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(
                            'Users',
                            style: GoogleFonts.poppins(),
                          ),
                          Button(
                              title: 'Update',
                              onPress: () {
                                usersController.edit(
                                  _uid.text.trim(),
                                  _firstName.text.trim(),
                                  _lastName.text.trim(),
                                  _email.text.trim(),
                                  _password.text.trim(),
                                  _level,
                                  _phone.text.trim(),
                                );
                              }),
                        ]);
            })),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _uid,
                  decoration: InputDecoration(
                    hintText: 'UID',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: TextFormField(
                          controller: _firstName,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          controller: _lastName,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _password,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                DropdownButtonFormField<dynamic>(
                  decoration: InputDecoration(
                    hintText: 'Select Level',
                    border: OutlineInputBorder(),
                  ),
                  value: _level,
                  onChanged: (dynamic newValue) {
                    setState(() {
                      _level = newValue!;
                    });
                  },
                  items: <String>['1', '2', '3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _phone,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
