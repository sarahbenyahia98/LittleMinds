import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_v1/controller/firebase_controller.dart';
import 'package:project_v1/models/youtube_model.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/widgets/input_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:file_picker/file_picker.dart';

class AdminEditingVideoScreen extends StatefulWidget {
  const AdminEditingVideoScreen({
    super.key,
  });

  @override
  State<AdminEditingVideoScreen> createState() =>
      _AdminEditingVideoScreenState();
}

class _AdminEditingVideoScreenState extends State<AdminEditingVideoScreen> {
  late final TextEditingController controllerTitle;
  late final TextEditingController controllerUrl;
  late final TextEditingController controllerDescription;
  @override
  void initState() {
    controllerTitle = TextEditingController();
    controllerDescription = TextEditingController();
    controllerUrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controllerTitle.dispose();
    controllerDescription.dispose();
    controllerUrl.dispose();
    super.dispose();
  }

  String generateRandomString(int length) {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  bool isValidYouTubeUrl(String id) {
    final RegExp regExp = RegExp(r'^[a-zA-Z0-9_-]{11}$');
  return regExp.hasMatch(id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SizedBox(
        width: AppConsts.getWidth(context),
        child: FutureBuilder<List<YoutubeModel>?>(
            future: FirebaseController().getAllYoutubes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            l10n.no_youtube_videos),
                        Text(l10n.add_video)
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: snapshot.data!.map((element) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            onTap: () {},
                            title: SizedBox(
                              width: AppConsts.getWidth(context) * 0.75,
                              child: Text(l10n.video_title + element.title,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            subtitle: SizedBox(
                                width: AppConsts.getWidth(context) * 0.75,
                                child: Text(
                                  l10n.video_description + element.description,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            trailing: SizedBox(
                              width: AppConsts.getWidth(context) * 0.25,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      controllerTitle.text = element.title;
                                      controllerDescription.text =
                                          element.description;
                                      controllerUrl.text = element.url;
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              l10n.edit_video+ element.title,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            content: Container(
                                              margin: EdgeInsets.all(10),
                                              height:
                                                  AppConsts.getHeight(context) *
                                                      0.3,
                                              width:
                                                  AppConsts.getWidth(context) *
                                                      0.8,
                                              child: Column(
                                                children: [
                                                  Spacer(),
                                                  InputWidget(
                                                      controller:
                                                          controllerTitle,
                                                      name: l10n.video_title,
                                                      textInputType:
                                                          TextInputType.name,
                                                      textInputAction:
                                                          TextInputAction.next),
                                                  Spacer(),
                                                  InputWidget(
                                                      controller: controllerUrl,
                                                      name: l10n.video_url,
                                                      textInputType:
                                                          TextInputType.url,
                                                      textInputAction:
                                                          TextInputAction.next),
                                                  Spacer(),
                                                  InputWidget(
                                                      controller:
                                                          controllerDescription,
                                                      name: l10n.video_description,
                                                      textInputType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.go),
                                                  Spacer(),
                                                  GestureDetector(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      width: AppConsts.getWidth(
                                                              context) *
                                                          0.8,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      height:
                                                          AppConsts.getHeight(
                                                                  context) *
                                                              0.04,
                                                      child: Center(
                                                        child: Text(
                                                          l10n.save,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.redAccent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                    onTap: () async {
                                                      if (controllerTitle.text
                                                              .isNotEmpty &&
                                                          controllerUrl.text
                                                              .isNotEmpty &&
                                                          controllerDescription
                                                              .text
                                                              .isNotEmpty &&
                                                          isValidYouTubeUrl(
                                                              controllerUrl
                                                                  .text)) {
                                                        Navigator.pop(context);
                                                        await FirebaseController().updateVideo(
                                                            video: YoutubeModel(
                                                                id: element.id,
                                                                title:
                                                                    controllerTitle
                                                                        .text,
                                                                description:
                                                                    controllerDescription
                                                                        .text,
                                                                url:
                                                                    controllerUrl
                                                                        .text));
                                                        setState(() {});
                                                      }
                                                    },
                                                  ),
                                                  Spacer(
                                                    flex: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      FirebaseController().deleteVideo(element);
                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
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
            }),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.tale,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  l10n.add_new_video,
                  style: TextStyle(fontSize: 16),
                ),
                content: Container(
                  margin: EdgeInsets.all(10),
                  height: AppConsts.getHeight(context) * 0.3,
                  width: AppConsts.getWidth(context) * 0.8,
                  child: Column(
                    children: [
                      Spacer(),
                      InputWidget(
                          controller: controllerTitle,
                          name: l10n.video_title,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.next),
                      Spacer(),
                      InputWidget(
                          controller: controllerUrl,
                          name: l10n.video_url,
                          textInputType: TextInputType.url,
                          textInputAction: TextInputAction.next),
                      Spacer(),
                      InputWidget(
                          controller: controllerDescription,
                          name: l10n.video_description,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.go),
                      Spacer(),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: AppConsts.getWidth(context) * 0.8,
                          padding: EdgeInsets.all(5),
                          height: AppConsts.getHeight(context) * 0.04,
                          child: Center(
                            child: Text(
                              l10n.save,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onTap: () async {
                          if (controllerTitle.text.isNotEmpty &&
                              controllerUrl.text.isNotEmpty &&
                              controllerDescription.text.isNotEmpty &&
                              isValidYouTubeUrl(controllerUrl.text)) {
                            Navigator.pop(context);
                            await FirebaseController().addYoutubeVideo(
                                youtube: YoutubeModel(
                                    id: generateRandomString(10),
                                    title: controllerTitle.text,
                                    description: controllerDescription.text,
                                    url: controllerUrl.text));
                            setState(() {});
                          }
                        },
                      ),
                      Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
