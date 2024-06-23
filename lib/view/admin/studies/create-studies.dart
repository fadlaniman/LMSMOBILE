import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/view/widgets/textButton.dart';

class CreateStudiesPage extends StatefulWidget {
  const CreateStudiesPage({super.key});

  @override
  State<CreateStudiesPage> createState() => _CreateStudiesPageState();
}

class _CreateStudiesPageState extends State<CreateStudiesPage> {
  final studiesController = Get.put(StudiesController());
  final _id = TextEditingController();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _duration = TextEditingController();
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close)),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Studies'),
                  Button(
                    title: 'Create',
                    onPress: () {
                      final duration = int.tryParse(_duration.text);
                      studiesController.send(_id.text.trim(), _name.text.trim(),
                          _description.text.trim(), duration!);
                    },
                  )
                ])),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _id,
                  decoration: InputDecoration(
                    hintText: 'ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _description,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty || value.length > 1) {
                      setState(() {
                        isValid = true;
                      });
                    }
                  },
                  controller: _duration,
                  decoration: InputDecoration(
                    hintText: 'Duration',
                    errorText: isValid ? 'only one number' : null,
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
