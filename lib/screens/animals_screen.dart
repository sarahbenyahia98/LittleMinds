import 'package:flutter/material.dart';
import 'package:project_v1/controller/local_language_controller.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/models/model_animals.dart';
import 'package:provider/provider.dart';

class AnimalScreen extends StatefulWidget {
  @override
  _AnimalScreenState createState() => _AnimalScreenState();
}

class _AnimalScreenState extends State<AnimalScreen> {
  @override
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
        title: Image.asset('assets/images/Logo_color.png',
            width: 120, height: 120),
      ),
      backgroundColor: AppColors.black,
      body: Center(
        child: buildModels(),
      ),
    );
  }

  Widget buildModels() {
    return ListView.builder(
      itemCount: animalsList.length,
      itemBuilder: (context, index) {
        LocalLanguageController provider = Provider.of(context, listen: false);
        return ModelStyle(
          cardModel: new CustomCardModel(
              title: animalsList[index][provider.locale?.countryCode??'en'].toString(),
              voice: animalsList[index]['voice'].toString(),
              image: animalsList[index]['imagePath'].toString()),
        );
      },
    );
  }
}
