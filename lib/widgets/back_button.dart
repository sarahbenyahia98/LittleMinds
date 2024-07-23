import 'package:flutter/material.dart';

class BackButtonCustomWidget extends StatelessWidget {
  const BackButtonCustomWidget({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, path);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ));
  }
}
