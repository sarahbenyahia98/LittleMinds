import 'package:flutter/material.dart';
import 'package:project_v1/controller/firebase_controller.dart';
import 'package:project_v1/models/user_model.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/app_routes.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/widgets/parent_statestic_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeParentWidget extends StatefulWidget {
  const HomeParentWidget({
    super.key,
  });

  @override
  State<HomeParentWidget> createState() => _HomeParentWidgetState();
}

class _HomeParentWidgetState extends State<HomeParentWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SizedBox(
        width: AppConsts.getWidth(context),
        child: FutureBuilder<List<UserModel>?>(
            future: FirebaseController().getAllKids(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          l10n.no_kids_yet,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          l10n.add_new_kid,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                } else {
                  return ParentStatesticPage(
                    users: snapshot.data!,
                  );
                }
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
            }),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.tale,
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoute.newKidScreen);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
