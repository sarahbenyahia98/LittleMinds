import 'package:flutter/material.dart';
import 'package:project_v1/controller/global_controller.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/widgets/admin_editing_pdf_screen.dart';
import 'package:project_v1/widgets/admin_editing_user_screen.dart';
import 'package:project_v1/widgets/admin_editing_video_screen.dart';
import 'package:project_v1/widgets/admin_profile_screen.dart';
import 'package:project_v1/widgets/language_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MainAdminScreen extends StatelessWidget {
  const MainAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    List<Widget> widgets = [
      AdminEditingUserScreen(),
      AdminEditingPdfScreen(),
      AdminEditingVideoScreen(),
     ProfileAdminScreen(),
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
        title: Text(l10n.admin_zone),
      ),
      body: SafeArea(
          minimum: EdgeInsets.all(10), child: widgets[provider.indexAdmin]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_document),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_back),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: provider.indexAdmin,
        selectedItemColor: AppColors.black,
        unselectedItemColor: Colors.blueGrey.withOpacity(0.3),
        onTap: (index) {
          provider.onChangeAdminIndex(index);
         
        },
      ),
    );
  }
}
