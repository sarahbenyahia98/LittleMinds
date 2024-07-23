import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_v1/controller/local_language_controller.dart';
import 'package:project_v1/l10n/l10n.dart';
import 'package:provider/provider.dart';

import 'package:project_v1/controller/global_controller.dart';
import 'package:project_v1/firebase_options.dart';
import 'package:project_v1/utils/app_routes.dart';
import 'package:project_v1/utils/constants.dart';

import 'controller/generalNotifier.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeneralNotifier()),
        ChangeNotifierProvider(create: (_) => GlobalController()),
        ChangeNotifierProvider(create: (_) => LocalLanguageController()),
      ],
      child: Consumer<LocalLanguageController>(
        builder: (context,provider,child) {
          return MaterialApp(
            supportedLocales: L10n.all,
            locale: provider.locale,
            title: 'Little Minds',
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(scaffoldBackgroundColor: AppColors.backGround),
            debugShowCheckedModeBanner: false,
            routes: AppRoute.routes
          );
        }
      ),
    );
  }
}

