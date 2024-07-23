import 'package:flutter/material.dart';
import 'package:project_v1/controller/firebase_controller.dart';
import 'package:project_v1/models/user_model.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/widgets/admin_card_widget.dart';
import 'package:project_v1/widgets/parent_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminEditingUserScreen extends StatefulWidget {
  const AdminEditingUserScreen({
    super.key,
  });

  @override
  State<AdminEditingUserScreen> createState() => _AdminEditingUserScreenState();
}

class _AdminEditingUserScreenState extends State<AdminEditingUserScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: AppConsts.getWidth(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Parents(l10n: l10n),
                SizedBox(height: AppConsts.getHeight(context) * 0.02),
                kids(l10n: l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<UserModel>?> Parents({required AppLocalizations l10n}) {
    return FutureBuilder<List<UserModel>?>(
      future: FirebaseController().getAllParent(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              height: AppConsts.getHeight(context) * 0.3,
              width: AppConsts.getWidth(context),
              child: Text(
                l10n.no_parents_yet,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            );
          }
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: AppConsts.getWidth(context) * 0.05, bottom: 10),
                alignment: Alignment.topLeft,
                child:
                    Text(l10n.list_of_parents, style: TextStyle(fontSize: 16)),
              ),
              SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: snapshot.data!.map((element) {
                      return ParentCardWidget(
                        parentModel: element,
                        onDelete: () {
                          FirebaseController()
                              .deleteParent(element.id.toString());
                          setState(() {});
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
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
      },
    );
  }

  FutureBuilder<List<UserModel>?> kids({required AppLocalizations l10n}) {
    return FutureBuilder<List<UserModel>?>(
      future: FirebaseController().getAllKidsForA(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              height: AppConsts.getHeight(context) * 0.3,
              width: AppConsts.getWidth(context),
              child: Text(
                l10n.no_kids_yet,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            );
          }
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: AppConsts.getWidth(context) * 0.05, bottom: 10),
                alignment: Alignment.topLeft,
                child: Text(l10n.list_of_kids, style: TextStyle(fontSize: 16)),
              ),
              SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: snapshot.data!.map((element) {
                      return KidCardWidget(
                        adminModel: element,
                        onDelete: () {
                          FirebaseController().deleteKid(element.id);
                          setState(() {});
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
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
      },
    );
  }
}
