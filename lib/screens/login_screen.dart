import 'package:flutter/material.dart';
import 'package:project_v1/controller/firebase_controller.dart';
import 'package:project_v1/controller/global_controller.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/app_routes.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/widgets/input_widget.dart';
import 'package:project_v1/widgets/language_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreenMobile extends StatefulWidget {
  const LoginScreenMobile({super.key});

  @override
  State<LoginScreenMobile> createState() => _LoginScreenMobileState();
}

class _LoginScreenMobileState extends State<LoginScreenMobile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    GlobalController provider =
        Provider.of<GlobalController>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          LanguageButtonWidget(),
          SizedBox(
            width: AppConsts.getWidth(context) * 0.05,
          )
        ],
        title: Text(AppLocalizations.of(context)!.login),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(top: 10),
        child: Visibility(
          child: Login(context, key: formKey),
        ),
      ),
    );
  }

  Container Login(BuildContext context, {required GlobalKey<FormState> key}) {
    return Container(
      width: AppConsts.getWidth(context),
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
              margin: EdgeInsets.only(left: AppConsts.getWidth(context) * 0.08),
              child: Text(
                AppLocalizations.of(context)!.welcome_to_our_app,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: AppConsts.getWidth(context) * 0.08),
              child: Text(
                AppLocalizations.of(context)!.monitor_child_progress,
                style: TextStyle(fontSize: 13, color: AppColors.black),
              ),
            ),
            SizedBox(
              height: AppConsts.getHeight(context) * 0.08,
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
                isPassword: true,
                textInputAction: TextInputAction.done),
            SizedBox(
              height: AppConsts.getHeight(context) * 0.04,
            ),
            GestureDetector(
              onTap: () {
                if (key.currentState!.validate()) {
                  FirebaseController().signIn(
                    context,
                    email: emailController.text,
                    password: passwordController.text,
                  );
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
                  AppLocalizations.of(context)!.login,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                )),
              ),
            ),
            SizedBox(
              height: AppConsts.getHeight(context) * 0.03,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoute.signupScreen);
              },
              child: Text(
                AppLocalizations.of(context)!.dont_have_account_signup,
                style: TextStyle(
                    color: Colors.black, decoration: TextDecoration.underline),
              ),
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
