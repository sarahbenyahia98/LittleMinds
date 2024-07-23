import 'package:flutter/material.dart';
import 'package:project_v1/utils/constants.dart';

class ShapeModel {
  String name, image;
  ShapeModel({
    required this.name,
    required this.image,
  });
}

class ShapeModelWidget extends StatefulWidget {
  final ShapeModel shapeModel;
  ShapeModelWidget({required this.shapeModel});

  @override
  State<ShapeModelWidget> createState() => _ShapeModelWidgetState();
}

class _ShapeModelWidgetState extends State<ShapeModelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 10),
            height: 230,
            child: Stack(
              children: [
                Positioned(
                  top: 30,
                  child: Container(
                    height: 180,
                    width: ScreenSize(context).width * 0.9,
                    decoration: BoxDecoration(
                      color: AppColors.skyblue, 
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  left: 10,
                  child: Card(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 175,
                      width: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.white.withOpacity(0.3),
                            spreadRadius: 2.5,
                            blurRadius: 4,
                            offset: Offset(0.5, 1.5),
                          )
                        ],
                        image: DecorationImage(
                          image: AssetImage(widget.shapeModel.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  left: 200,
                  child: Container(
                    height: 125,
                    width: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PrimaryText(
                          text: widget.shapeModel.name,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          size: 35,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
