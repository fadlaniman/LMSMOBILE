import 'package:flutter/material.dart';
import 'package:mobile/view/student/studies/classwork.dart';
import 'package:mobile/view/student/studies/people.dart';
import 'package:mobile/view/student/studies/stream.dart';
import 'package:mobile/view/widgets/header.dart';
import 'package:mobile/view/widgets/navigationTop.dart';

class Studies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StudiesWidget();
  }
}

class StudiesWidget extends StatefulWidget {
  const StudiesWidget({super.key});

  @override
  State<StudiesWidget> createState() => _StudiesWidgetState();
}

class _StudiesWidgetState extends State<StudiesWidget> {
  int _currentIndex = 0;
  List<Widget> body = const [StreamWidget(), ClassworkWidget(), PeopleWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Header(
            title: '',
          ),
        ),
        drawer: NavigationWidget(),
        body: body[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(color: Colors.red, fontSize: 14.0),
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.video_call_outlined), label: 'Stream'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.class_outlined), label: 'Classwork'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt_outlined), label: 'People'),
            ]));
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
