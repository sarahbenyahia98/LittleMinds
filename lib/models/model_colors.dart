import 'package:flutter/material.dart';
import 'package:project_v1/utils/constants.dart';

import '../screens/colors_screen.dart';

class ColorModelWidget extends StatefulWidget {
  final ColorModel colorModel;
  ColorModelWidget({required this.colorModel});

  @override
  State<ColorModelWidget> createState() => _ColorModelWidgetState();
}

class _ColorModelWidgetState extends State<ColorModelWidget> {
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
                      color: AppColors.pastelBlue, // Change color as needed
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
                          image: AssetImage(widget.colorModel.imagePath),
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
                          text: widget.colorModel.name,
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
