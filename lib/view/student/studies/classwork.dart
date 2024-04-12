import 'package:flutter/material.dart';

class ClassworkWidget extends StatefulWidget {
  const ClassworkWidget({super.key});

  @override
  State<ClassworkWidget> createState() => _ClassworkWidgetState();
}

class _ClassworkWidgetState extends State<ClassworkWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Classwork'),
    );
  }
}
