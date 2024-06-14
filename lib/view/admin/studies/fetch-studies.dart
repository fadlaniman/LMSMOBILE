import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/view/admin/studies/create-studies.dart';
import 'package:mobile/view/assets/style.dart';
import 'package:mobile/view/widgets/floatingButtonBottom.dart';

class ReadStudiesPage extends StatefulWidget {
  const ReadStudiesPage({super.key});

  @override
  State<ReadStudiesPage> createState() => _ReadStudiesPageState();
}

class _ReadStudiesPageState extends State<ReadStudiesPage> {
  final studiesController = Get.put(StudiesController());

  @override
  void initState() {
    studiesController
        .fetch()
        .then((value) => studiesController.studies.assignAll(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Studies',
            style: GoogleFonts.poppins(),
          ),
        ),
        body: Obx(() {
          return studiesController.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: studiesController.studies.length,
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
                        title: Text(
                          studiesController.studies[index].id,
                          style: GoogleFonts.poppins(),
                        ),
                        subtitle: Text(
                            studiesController.studies[index].name.toString(),
                            style: GoogleFonts.poppins()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit), onPressed: () {}),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      titleTextStyle: GoogleFonts.poppins(
                                          color: Colors.black),
                                      title: const Text(
                                        'Alert',
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
                                          onPressed: () {},
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
          onPress: () => Get.to(() => const CreateStudiesPage()),
        ));
  }
}
