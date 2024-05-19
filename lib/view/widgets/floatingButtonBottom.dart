import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatelessWidget {
  FloatingButtonWidget(
      {super.key,
      required this.onPress,
      required this.color,
      required this.backgroundColor});
  final onPress;
  final color;
  final backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(1, 1))
            ]),
        child: IconButton(
            onPressed: onPress,
            icon: Icon(
              Icons.add,
              size: 30.0,
              color: color,
            )));
  }
}
