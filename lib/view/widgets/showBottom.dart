import 'package:flutter/material.dart';

class ShowBottom {
  showModalBottom(BuildContext context,
      {required String title, required dynamic onTap}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(10.0)),
              padding: EdgeInsets.all(10.0),
              child: Wrap(
                children: [
                  ListTile(
                    onTap: onTap,
                    title: Text(title),
                  )
                ],
              ));
        });
  }
}
