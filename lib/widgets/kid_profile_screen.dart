import 'package:flutter/material.dart';
import 'package:project_v1/controller/firebase_controller.dart';
import 'package:project_v1/controller/global_controller.dart';
import 'package:project_v1/models/role_enum.dart';
import 'package:project_v1/models/user_model.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/app_routes.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/widgets/input_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ProfileKidScreen extends StatefulWidget {
  const ProfileKidScreen({
    super.key,
  });

  @override
  State<ProfileKidScreen> createState() => _ProfileKidScreenState();
}

class _ProfileKidScreenState extends State<ProfileKidScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  late String id;
  final TextEditingController displayNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    FirebaseController().getKidData().then((value) {
      print(value);
      setState(() {
        emailController.text = value?.email ?? "";
        displayNameController.text = value?.displayName ?? "";
        passwordController.text = value?.password ?? "";
        ageController.text = value?.age ?? "0";
        id = value?.id ?? "";
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.pale,
      appBar: AppBar(
        elevation: 0,
       backgroundColor: AppColors.pale,
        centerTitle: true,
        title: Text(l10n.profile),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoute.mainScreen);
          },
        ),
      ),
      body: Container(
          height: AppConsts.getHeight(context),
          width: AppConsts.getWidth(context),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: AppConsts.getHeight(context) * 0.08,
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
                    isId: true,
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
                    isId: true,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done),
                SizedBox(
                  height: AppConsts.getHeight(context) * 0.04,
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      UserModel parent = UserModel(
                          id: id,
                          age: ageController.text,
                          displayName: displayNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          role: RoleEnum.Child.name);
                      await FirebaseController().updateAdmin(parent: parent);
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
                      l10n.edit,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )),
                  ),
                ),
                SizedBox(
                  height: AppConsts.getHeight(context) * 0.02,
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseController().signOut();
                    Navigator.pushReplacementNamed(
                        context, AppRoute.loginScreen);
                    Provider.of<GlobalController>(context, listen: false)
                        .onChangeIndex(0);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: AppConsts.getWidth(context) * 0.5,
                    height: AppConsts.getHeight(context) * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      border: null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(l10n.logout,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                  ),
                ),
                Spacer(),
                Image.asset("assets/images/Logo_color.png",width: AppConsts.getWidth(context)*0.6,),
                SizedBox(height: AppConsts.getHeight(context)*0.04,),
                Image.asset("assets/gamesFooter.png")
              ],
            ),
          )),
    );
  }
}
