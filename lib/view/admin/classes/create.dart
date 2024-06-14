import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/controller/studiesController.dart';
import 'package:mobile/controller/usersController.dart';

class CreateClassPage extends StatefulWidget {
  const CreateClassPage({super.key});

  @override
  State<CreateClassPage> createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  final usersController = Get.put(UsersController());
  final name = TextEditingController();
  final section = TextEditingController();
  final subject = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 50),
                  child: Icon(
                    Icons.person_add,
                    size: 40,
                    color: Color.fromARGB(255, 68, 138, 255),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 50),
                  child: Text(
                    'Add User',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              RotatedBox(
                quarterTurns: 1,
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  // decoration: const BoxDecoration(
                  //     gradient: LinearGradient(colors: [
                  //   Colors.amber,
                  //   Colors.amber,
                  // ])),
                  width: 300,
                  height: 250,
                  child: const TabBar(
                      indicatorPadding: EdgeInsets.all(10),
                      indicatorWeight: 13,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      unselectedLabelStyle: TextStyle(
                        backgroundColor: Colors.white,
                      ),
                      padding: EdgeInsets.only(top: 0),
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: TextStyle(
                          backgroundColor: Colors.green,
                          //color: Colors.black,
                          fontFamily: 'RobotoMono',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      tabs: [
                        RotatedBox(quarterTurns: 3, child: Text('Add Student')),
                        RotatedBox(
                          quarterTurns: 3,
                          child: Text('Add Teacher'),
                        ),
                        RotatedBox(
                            quarterTurns: 3, child: Text('Add Director')),
                        RotatedBox(quarterTurns: 3, child: Text('Add Parent')),
                        RotatedBox(quarterTurns: 3, child: Text('Add Subject')),
                      ]),
                ),
              ),
              const Flexible(
                child: Card(
                  elevation: 30,
                  margin: EdgeInsets.only(left: 150, right: 200),
                  child: SizedBox(
                    //padding: const EdgeInsets.only(left: 150, right: 200),
                    //width: double.maxFinite,
                    height: 550,
                    child: TabBarView(
                      children: [],
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
