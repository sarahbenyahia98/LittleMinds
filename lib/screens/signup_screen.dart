import 'package:flutter/material.dart';
import 'package:project_v1/controller/firebase_controller.dart';
import 'package:project_v1/controller/global_controller.dart';
import 'package:project_v1/models/role_enum.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/app_routes.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/widgets/input_widget.dart';
import 'package:project_v1/widgets/language_button_widget.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SignUpScreenMobile extends StatefulWidget {
  const SignUpScreenMobile({super.key});

  @override
  State<SignUpScreenMobile> createState() => _SignUpScreenMobileState();
}

class _SignUpScreenMobileState extends State<SignUpScreenMobile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController kidsController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    displayNameController.dispose();
    kidsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalController provider =
        Provider.of<GlobalController>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.sign_up),
        centerTitle: true,
        actions: [
          LanguageButtonWidget(),
          SizedBox(width: AppConsts.getWidth(context)*0.05,)
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(top: 10),
        child: signup(context, key: formKey),
      ),
    );
  }

  Widget signup(BuildContext context, {required GlobalKey<FormState> key}) {
    return SingleChildScrollView(
      child: Container(
        width: AppConsts.getWidth(context),
        height: AppConsts.getHeight(context),
        child: Form(
          key: key,
          child: Column(
            children: [
              Spacer(),
              Image.asset(
                "assets/images/Logo_color.png",
                width: AppConsts.getWidth(context) * 0.7,
              ),
              Spacer(),
              Container(
                alignment: Alignment.topLeft,
                margin:
                    EdgeInsets.only(left: AppConsts.getWidth(context) * 0.08),
                child: Text(
                  AppLocalizations.of(context)!.welcome_to_our_app,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin:
                    EdgeInsets.only(left: AppConsts.getWidth(context) * 0.08),
                child: Text(
                  AppLocalizations.of(context)!.create_parent_account,
                  style: TextStyle(fontSize: 13, color: AppColors.black),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin:
                    EdgeInsets.only(left: AppConsts.getWidth(context) * 0.08),
                child: Text(
                  AppLocalizations.of(context)!.monitor_child_progress,
                  style: TextStyle(fontSize: 13, color: AppColors.black),
                ),
              ),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.08,
              ),
              InputWidget(
                  controller: displayNameController,
                  name: AppLocalizations.of(context)!.display_name,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.02,
              ),
              InputWidget(
                  controller: emailController,
                  name: AppLocalizations.of(context)!.email,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.02,
              ),
              InputWidget(
                  controller: passwordController,
                  name: AppLocalizations.of(context)!.password,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.02,
              ),
              InputWidget(
                  controller: repasswordController,
                  name: AppLocalizations.of(context)!.password_again,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.04,
              ),
              GestureDetector(
                onTap: () async {
                  if (key.currentState!.validate() &&
                      passwordController.text == repasswordController.text) {
                    await FirebaseController().signUp(context,
                        email: emailController.text,
                        password: passwordController.text,
                        displayName: displayNameController.text,
                        role: RoleEnum.Parent);
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
                    AppLocalizations.of(context)!.sign_up,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  )),
                ),
              ),
              SizedBox(
                height: AppConsts.getHeight(context) * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRoute.loginScreen);
                },
                child: Text(
                  AppLocalizations.of(context)!.have_account_login,
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ),
              ),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
