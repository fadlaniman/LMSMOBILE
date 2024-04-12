import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.title, required this.onPress});
  final String title;
  final dynamic onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPress,
        child: Text(title),
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll<Color>(Color.fromARGB(255, 218, 33, 16)),
          foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ));
  }
}
