import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_v1/controller/firebase_controller.dart';
import 'package:project_v1/models/user_model.dart';
import 'package:project_v1/models/youtube_model.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/widgets/admin_card_widget.dart';
import 'package:project_v1/widgets/video_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainVideoScreen extends StatefulWidget {
  const MainVideoScreen({
    super.key,
  });

  @override
  State<MainVideoScreen> createState() => _MainVideoScreenState();
}

class _MainVideoScreenState extends State<MainVideoScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.pale,
      appBar: AppBar(
        centerTitle: true,
       backgroundColor: AppColors.pale,
        title: Text(l10n.list_of_videos),
      ),
      body: SafeArea(
          minimum: EdgeInsets.fromLTRB(5, 20, 5, 5),
          child: SizedBox(
            width: AppConsts.getWidth(context),
            child: videos(l10n),
          )),
    );
  }

  FutureBuilder<List<YoutubeModel>?> videos(l10n) {
    return FutureBuilder<List<YoutubeModel>?>(
        future: FirebaseController().getAllYoutubes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length == 0) {
              return Container(
                alignment: Alignment.center,
                height: AppConsts.getHeight(context) * 0.3,
                width: AppConsts.getWidth(context),
                child: Text(
                  l10n.no_video_yet,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      decoration: TextDecoration.underline),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: snapshot.data!.map((element) {
                    return VideoCardWidget(
                      youtubeModel: element,
                    );
                  }).toList()),
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
        });
  }
}
