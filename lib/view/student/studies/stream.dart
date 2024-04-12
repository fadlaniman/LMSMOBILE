import 'package:flutter/material.dart';

class StreamWidget extends StatefulWidget {
  const StreamWidget({super.key});

  @override
  State<StreamWidget> createState() => _StreamWidgetState();
}

class _StreamWidgetState extends State<StreamWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('stream'),
    );
  }
}
