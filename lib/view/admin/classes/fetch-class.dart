import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/classController.dart';
import 'package:mobile/view/admin/classes/create-class.dart';
import 'package:mobile/view/admin/studies/create-studies.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/widgets/floatingButtonBottom.dart';

class FetchClassPage extends StatefulWidget {
  const FetchClassPage({super.key});

  @override
  State<FetchClassPage> createState() => _FetchClassPageState();
}

class _FetchClassPageState extends State<FetchClassPage> {
  final ClassController classController = Get.find();
  int number = 1;
  @override
  void initState() {
    classController.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return classController.loading.value
                ? Text(
                    'Loading...',
                    style: GoogleFonts.poppins(),
                  )
                : Text(
                    'Class',
                    style: GoogleFonts.poppins(),
                  );
          }),
        ),
        body: Obx(() {
          return classController.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: classController.classes.length,
                  itemBuilder: (context, index) {
                    return Container(
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
                          classController.classes[index].users.email,
                          style: GoogleFonts.poppins(fontSize: 14.0),
                        ),
                        subtitle: Text(
                            '${classController.classes[index].classes.id} - ${classController.classes[index].classes.name}',
                            style: GoogleFonts.poppins(fontSize: 12.0)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                                            classController.delete(
                                                classController
                                                    .classes[index].id);
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
          onPress: () => Get.to(() => const CreateClassPage()),
        ));
  }
}
