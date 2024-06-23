import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/usersController.dart';
import 'package:mobile/view/admin/users/create-users.dart';
import 'package:mobile/view/admin/users/update-users.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/widgets/floatingButtonBottom.dart';

class FetchUsersPage extends StatefulWidget {
  const FetchUsersPage({super.key});

  @override
  State<FetchUsersPage> createState() => _FetchUsersPageState();
}

class _FetchUsersPageState extends State<FetchUsersPage> {
  final UsersController usersController = Get.find();

  @override
  void initState() {
    usersController.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return usersController.loading.value
                ? Text(
                    'Loading...',
                    style: GoogleFonts.poppins(),
                  )
                : Text(
                    'Users',
                    style: GoogleFonts.poppins(),
                  );
          }),
        ),
        body: Obx(() {
          return usersController.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: usersController.users.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        leading: Text(
                          '${index + 1}',
                          style: GoogleFonts.poppins(fontSize: 12.0),
                        ),
                        title: Text(
                          usersController.users[index].email ?? '',
                          style: GoogleFonts.poppins(fontSize: 14.0),
                        ),
                        subtitle: Text(
                            usersController.users[index].uid.toString(),
                            style: GoogleFonts.poppins(fontSize: 12.0)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.yellow.shade700,
                                ),
                                onPressed: () {
                                  usersController.fetchById(
                                      usersController.users[index].uid ?? 0);
                                  Get.to(() => const UpdateUsersPage());
                                }),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: primaryColor,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      titleTextStyle: GoogleFonts.poppins(
                                          color: Colors.black),
                                      title: const Text(
                                        'Delete',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 18.0),
                                      ),
                                      content: const Text(
                                        'Are you sure want to delete this record?',
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('No'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Yes'),
                                          onPressed: () {
                                            usersController.delete(
                                                usersController
                                                        .users[index].uid ??
                                                    0);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  });
        }),
        floatingActionButton: FloatingButtonWidget(
          backgroundColor: Colors.white,
          color: primaryColor,
          onPress: () => Get.to(() => const CreateUsersPage()),
        ));
  }
}
