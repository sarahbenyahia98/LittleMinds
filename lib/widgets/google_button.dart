import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_v1/utils/app_consts.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton(
      {super.key,
      required this.backgroundColor,
      required this.onPress,
      required this.textColor,
      required this.text});
  final Color backgroundColor;
  final Color textColor;
  final Function() onPress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: AppConsts.getWidth(context) * 0.5,
        //height: AppConst.getHeight(context)*0.07,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              "icons/Google.svg",
              height: 20,
              width: 20,
            ),
            const Spacer(),
            Text(
              text,
              style: TextStyle(
                  color: textColor, fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
