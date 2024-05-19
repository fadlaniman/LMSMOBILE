import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.title, required this.onPress});
  final String title;
  final dynamic onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPress,
        child: Text(
          title,
          style: GoogleFonts.poppins(),
        ),
        style: ButtonStyle(
          padding:
              MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 15.0)),
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
