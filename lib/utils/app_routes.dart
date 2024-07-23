import 'package:flutter/src/widgets/framework.dart';
import 'package:project_v1/screens/Countries.dart';
import 'package:project_v1/screens/Games/color_match.dart';
import 'package:project_v1/screens/Games/memory.dart';
import 'package:project_v1/screens/Games/startup.dart';
import 'package:project_v1/screens/animals_screen.dart';
import 'package:project_v1/screens/body_parts.dart';
import 'package:project_v1/screens/colors_screen.dart';
import 'package:project_v1/screens/days_screen.dart';
import 'package:project_v1/screens/family_screen.dart';
import 'package:project_v1/screens/fruits_screen.dart';
import 'package:project_v1/screens/games_screen.dart';
import 'package:project_v1/screens/letters_screen.dart';
import 'package:project_v1/screens/login_screen.dart';
import 'package:project_v1/screens/main_admin_screen.dart';
import 'package:project_v1/screens/main_parent_screen.dart';
import 'package:project_v1/screens/main_pdf_screen.dart';
import 'package:project_v1/screens/main_quizz_screen.dart';
import 'package:project_v1/screens/main_screen.dart';
import 'package:project_v1/screens/main_video_screen.dart';
import 'package:project_v1/screens/months_screen.dart';
import 'package:project_v1/screens/new_kid_screen.dart';
import 'package:project_v1/screens/nums_screen.dart';

import 'package:project_v1/screens/shapes.dart';
import 'package:project_v1/screens/signup_screen.dart';
import 'package:project_v1/screens/splash_screen.dart';
import 'package:project_v1/screens/vegetables_screen.dart';
import 'package:project_v1/screens/youtube_watch_screen.dart';
import 'package:project_v1/widgets/kid_profile_screen.dart';

class AppRoute {
  static const String splashScreen = '/';
  static const String mainScreen = '/Main';
  static const String loginScreen = '/loginScreen';
  static const String countriesScreen = '/Countries';
  static const String numsScreen = '/Nums';
  static const String animalsScreen = '/Animals';
  static const String lettersScreen = '/Letters';
  static const String familyScreen = '/Family';
  static const String colorsScreen = '/Colors';
  static const String monthsScreen = '/Months';
  static const String daysScreen = '/Days';
  static const String gamesScreen = '/Games';
  static const String colorScreen = '/Color';
  static const String memoryScreen = '/Memory';
  static const String fruitsScreen = '/Fruits';
  static const String vegetablesScreen = '/Vegetables';
  static const String startupPageScreen = '/Vegetables';
  static const String bodyPartsScreen = '/BodyParts';
  static const String shapesScreen = '/Shapes';
  static const String signupScreen = '/signup';
  static const String mainParentScreen = "/mainScrean";
  static const String newKidScreen = "/newKidScreen";
  static const String editKidScreen = "/editKidEscreen";
  static const String mainAdminScreen = "/mainAdminScreen";
  static const String pdfViewer = "/pdfViwer";
  static const String quizzMainScreen = "/quizzMainScreen";
  static const String videoMainScreen = "/videoMainScreen";
  static const String youtubeWatchScreen = "/youtubeWatchScreen";
  static const String pdfWatchScreen = "/pdfWatchScreen";
  static const String kidProfileScreen = "/kidProfileScreen";
  static Map<String, Widget Function(dynamic context)> routes = {
    '/': (context) => SplashScreen(),
    mainScreen: (context) => MainScreen(),
    '/Nums': (context) => NumsScreen(),
    '/Animals': (context) => AnimalScreen(),
    '/Letters': (context) => LettersScreen(),
    '/Family': (context) => FamilyScreen(),
    '/Colors': (context) => ColorsScreen(),
    '/Months': (context) => MonthsScreen(),
    '/Days': (context) => WeekdaysScreen(),
    '/Countries': (context) => CountriesScreen(),
    '/Games': (context) => GameScreen(),
    '/Color': (context) => ColorMatch(),
    '/Memory': (context) => Memory(),
    '/Fruits': (context) => Fruits(),
    '/Vegetables': (context) => Vegetables(),
    '/StartupPage': (context) => StartupPage(),
    '/BodyParts': (context) => BodyPartsScreen(),
    '/Shapes': (context) => ShapesScreen(),
    loginScreen: (context) => LoginScreenMobile(),
    signupScreen: (context) => SignUpScreenMobile(),
    mainParentScreen: (context) => MainParentScreen(),
    newKidScreen: (context) => NewKidScreen(),
    mainAdminScreen: (context) => MainAdminScreen(),
    quizzMainScreen: (context) => MainQuizzScreen(),
    videoMainScreen: (context) => MainVideoScreen(),
    pdfWatchScreen: (context) => MainPdfScreen(),
    kidProfileScreen: (context) => ProfileKidScreen()
  };
}
