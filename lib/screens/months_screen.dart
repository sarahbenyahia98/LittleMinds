import 'package:flutter/material.dart';
import 'package:project_v1/controller/local_language_controller.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:provider/provider.dart';

import '../models/month_model.dart';

class MonthModel {
  String name, image;
  MonthModel({
    required this.name,
    required this.image,
  });
}

class MonthsScreen extends StatefulWidget {
  @override
  _MonthsScreenState createState() => _MonthsScreenState();
}

class _MonthsScreenState extends State<MonthsScreen> {
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
        child: buildMonths(),
      ),
    );
  }

  Widget buildMonths() {
    return ListView.builder(
      itemCount: monthsList.length,
      itemBuilder: (context, index) {
        LocalLanguageController provider = Provider.of(context, listen: false);
        return MonthModelWidget(
          monthModel: MonthModel(
            name: monthsList[index][provider.locale?.languageCode??'en'].toString(),
            image: monthsList[index]['imagePath'].toString(),
          ),
        );
      },
    );
  }
}
