import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/view/widgets/showBottom.dart';

class FloatingButtonWidget extends StatelessWidget {
  FloatingButtonWidget({super.key, this.onPress});
  final dynamic onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(1, 1))
            ]),
        child: IconButton(
            onPressed: onPress,
            icon: Icon(
              Icons.add,
              size: 30.0,
              color: Colors.red,
            )));
  }
}
