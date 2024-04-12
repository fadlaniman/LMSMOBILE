import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  InputWidget({
    super.key,
    required,
    required this.controller,
    required this.title,
  });
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        ),
      ),
    );
  }
}
