import 'package:flutter/material.dart';

class ShowBottom {
  showModalBottom(BuildContext context, final listView) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(10.0)),
              padding: EdgeInsets.all(10.0),
              child: listView);
        });
  }
}
