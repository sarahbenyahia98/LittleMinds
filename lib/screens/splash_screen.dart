import 'package:flutter/material.dart';
import 'package:project_v1/controller/firebase_controller.dart';
import 'package:project_v1/controller/global_controller.dart';
import 'package:project_v1/models/role_enum.dart';
import 'package:project_v1/utils/app_routes.dart';
import 'dart:async';
import 'package:project_v1/utils/constants.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      RoleEnum role =
          await Provider.of<GlobalController>(context, listen: false)
              .ongetRole();
      print(role);
      if (FirebaseController().isUserConnected() && role == RoleEnum.Parent) {
        Navigator.of(context).pushReplacementNamed(AppRoute.mainParentScreen);
      } else if (FirebaseController().isUserConnected() &&
          role == RoleEnum.Admin) {
        Navigator.of(context).pushReplacementNamed(AppRoute.mainAdminScreen);
      } else if (FirebaseController().isUserConnected() &&
          role == RoleEnum.Child) {
        Navigator.pushReplacementNamed(context, AppRoute.mainScreen);
      } else {
        Navigator.pushReplacementNamed(context, AppRoute.loginScreen);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: AppColors.black,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/Logo_color.png',
              width: ScreenSize(context).width * 0.6,
              height: ScreenSize(context).height * 0.75,
            ),
            CircularProgressIndicator(color: AppColors.secondary)
          ],
        ),
      ),
    );
  }
}
