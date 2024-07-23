import 'package:flutter/material.dart';
import 'package:project_v1/controller/local_language_controller.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/models/model_shapes.dart';
import 'package:provider/provider.dart'; // Import the shape model

class ShapesScreen extends StatefulWidget {
  @override
  _ShapesScreenState createState() => _ShapesScreenState();
}

class _ShapesScreenState extends State<ShapesScreen> {
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
        child: buildShapes(),
      ),
    );
  }

  Widget buildShapes() {
    return ListView.builder(
      itemCount: shapesList.length,
      itemBuilder: (context, index) {
        LocalLanguageController provider = Provider.of(context, listen: false);
        return ShapeModelWidget(
          shapeModel: ShapeModel(
            name: shapesList[index][provider.locale?.languageCode ?? 'en']
                .toString(),
            image: shapesList[index]['image'].toString(),
          ),
        );
      },
    );
  }
}
