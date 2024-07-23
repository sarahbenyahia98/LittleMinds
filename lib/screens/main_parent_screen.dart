import 'package:flutter/material.dart';
import 'package:project_v1/controller/global_controller.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/widgets/home_parent_widget.dart';
import 'package:project_v1/widgets/language_button_widget.dart';
import 'package:project_v1/widgets/parent_profile_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MainParentScreen extends StatelessWidget {
  const MainParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final l10n = AppLocalizations.of(context)!;
    List<Widget> widgets = [
      HomeParentWidget(),
      ProfileParentWidget(),
    ];
    GlobalController provider = Provider.of<GlobalController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          LanguageButtonWidget(),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Colors.white,
        title: Text(l10n.parent_zone),
      ),
      body: SafeArea(
          minimum: EdgeInsets.all(10), child: widgets[provider.indexParent]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: l10n.profile,
          ),
        ],
        currentIndex: provider.indexParent,
        selectedItemColor:AppColors.black,
        onTap: (index) {
          provider.onChangeIndex(index);
        },
      ),
    );
  }
}


