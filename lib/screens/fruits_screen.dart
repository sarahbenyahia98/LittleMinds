import 'package:flutter/material.dart';
import 'package:project_v1/controller/local_language_controller.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/models/default_model.dart';
import 'package:provider/provider.dart';

class Fruits extends StatefulWidget {
  @override
  _FruitsState createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.backGround),
        ),
        title:
            Image.asset('assets/images/Logo_color.png', width: 120, height: 120),
      ),
      backgroundColor: AppColors.black,
      body: Center(
        child: buildModels(),
      ),
    );
  }

  Widget buildModels() {
    return ListView.builder(
      itemCount: fruitsList.length,
      itemBuilder: (context, index) {
        LocalLanguageController provider = Provider.of(context, listen: false);
        return ModelStyle(
          cardModel: new CustomCardModel(
              title: fruitsList[index][provider.locale?.languageCode??'en'].toString(),
              image: fruitsList[index]['imagePath'].toString()),
        );
      },
    );
  }
}
