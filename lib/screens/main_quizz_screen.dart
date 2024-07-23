import 'package:flutter/material.dart';
import 'package:project_v1/controller/firebase_controller.dart';
import 'package:project_v1/utils/constants.dart';

class MainQuizzScreen extends StatefulWidget {
  const MainQuizzScreen({super.key});

  @override
  State<MainQuizzScreen> createState() => _MainQuizzScreenState();
}

class _MainQuizzScreenState extends State<MainQuizzScreen> {
  var list = [];
  @override
  void initState() {
    CardsList.map((element) {
      FirebaseController().getCourseImage(element['imagePath']!).then((value) {
        print(value);
        setState(() {
          list.add(value);
        });
      });
    });
    print(list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
            children: list.map((value) {
          return Image.network(value!);
        }).toList()));
  }
}
