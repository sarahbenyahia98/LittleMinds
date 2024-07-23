import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_v1/controller/firebase_controller.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/app_routes.dart';
import 'package:project_v1/widgets/back_button.dart';
import 'package:project_v1/widgets/input_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewKidScreen extends StatefulWidget {
  const NewKidScreen({super.key});

  @override
  State<NewKidScreen> createState() => _NewKidScreenState();
}

class _NewKidScreenState extends State<NewKidScreen> {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String parentPassword = "";

  @override
  void initState() {
    FirebaseController().getParentData().then((value) {
      parentPassword = value?.password ?? "";
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    displayNameController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    ageController.dispose();

    super.dispose();
  }

  String generateRandomString(int length) {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: BackButtonCustomWidget(
            path: AppRoute.mainParentScreen,
          ),
          backgroundColor: Colors.white,
          title: Text(l10n.add_new_kid),
        ),
        body: SafeArea(
            child: SizedBox(
          width: AppConsts.getWidth(context),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(children: [
                SizedBox(
                  height: AppConsts.getHeight(context) * 0.02,
                ),
                InputWidget(
                    controller: displayNameController,
                    name: l10n.display_name,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next),
                SizedBox(
                  height: AppConsts.getHeight(context) * 0.02,
                ),
                InputWidget(
                    controller: emailController,
                    name: l10n.email,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next),
                SizedBox(
                  height: AppConsts.getHeight(context) * 0.02,
                ),
                InputWidget(
                    controller: ageController,
                    name: l10n.age,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next),
                SizedBox(
                  height: AppConsts.getHeight(context) * 0.02,
                ),
                InputWidget(
                    controller: passwordController,
                    name: l10n.password,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next),
                SizedBox(
                  height: AppConsts.getHeight(context) * 0.02,
                ),
                InputWidget(
                    controller: rePasswordController,
                    name: l10n.password_again,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done),
                SizedBox(
                  height: AppConsts.getHeight(context) * 0.04,
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate() &&
                        passwordController.text == rePasswordController.text) {
                      FirebaseController()
                          .addKid(
                        context,
                        parentPassword: parentPassword,
                        parentUid:
                            FirebaseController().getCurrentUser()?.uid ?? "",
                        email: emailController.text,
                        password: passwordController.text,
                        displayName: displayNameController.text,
                      )
                          .then((_) {
                        Navigator.pushReplacementNamed(
                            context, AppRoute.mainParentScreen);
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: AppConsts.getWidth(context) * 0.5,
                    height: AppConsts.getHeight(context) * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      l10n.save,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )),
                  ),
                ),
              ]),
            ),
          ),
        )));
  }
}
