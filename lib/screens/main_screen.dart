import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_v1/controller/local_language_controller.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/app_routes.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project_v1/widgets/language_button_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedCard = -1;
  int selectedActivity = -1;
  Color _colorContainer = AppColors.crimson;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    LocalLanguageController provider = Provider.of(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.backGround,
        elevation: 0,
        actions: [
          LanguageButtonWidget(),
          SizedBox(
            width: 10,
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoute.kidProfileScreen);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              header(l10n, provider),
              SizedBox(height: ScreenSize(context).height * 0.025),
              buildCards(context),
              SizedBox(height: ScreenSize(context).height * 0.025),
              games(l10n),
              pdfs(l10n),
              youtube(l10n),
            ],
          ),
        ),
      ),
    );
  }

  Container header(l10n, LocalLanguageController provider) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backGround,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: provider.locale?.languageCode == 'ar'
                ? EdgeInsets.only(right: 15)
                : EdgeInsets.only(left: 15),
            child: PrimaryText(
              text: l10n.welcome,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              size: 30,
            ),
          ),
          Padding(
              padding: provider.locale?.languageCode == 'ar'
                  ? EdgeInsets.only(right: 15)
                  : EdgeInsets.only(left: 15),
              child: PrimaryText(
                text: l10n.learn_today,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                size: 30,
              )),
          SizedBox(height: ScreenSize(context).height * 0.03),
          Padding(
              padding: provider.locale?.languageCode == 'ar'
                  ? EdgeInsets.only(right: 15)
                  : EdgeInsets.only(left: 15),
              child: PrimaryText(
                text: l10n.learning_journey,
                size: 18,
                color: AppColors.black,
              )),
          SizedBox(height: ScreenSize(context).height * 0.03)
        ],
      ),
    );
  }

  Widget cardsStyle(String imagePath, String name, int index) {
    return InkWell(
      onTap: () => {
        setState(
          () {
            selectedCard = index;
            print('routes list ');
            print(routesList.length);
            Navigator.pushNamed(
                context, routesList[index]['routePath'].toString());
          },
        ),
      },
      child: Container(
        margin: EdgeInsets.all(18),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: selectedCard == index
                ? AppColors.backGround
                : AppColors.secondary,
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary,
                blurRadius: 2,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.transparent,
              height: 90,
              width: 90,
              child: SvgPicture.asset("assets/"+imagePath, fit: BoxFit.contain),
            ), //TODO
            PrimaryText(text: name, fontWeight: FontWeight.w800, size: 14),
          ],
        ),
      ),
    );
  }

  SizedBox buildCards(BuildContext context) {
    LocalLanguageController provider =
        Provider.of<LocalLanguageController>(context, listen: false);
    return SizedBox(
      height: AppConsts.getHeight(context)*0.9,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: List.generate(
          CardsList.length,
          (index) => cardsStyle(
              CardsList[index]['imagePath'].toString(),
              CardsList[index][provider.locale?.languageCode ?? 'en']
                  .toString(),
              index),
        ),
      ),
    );
  }

  InkWell pdfs(l10n) {
    return InkWell(
      child: Container(
        height: 125,
        width: ScreenSize(context).width * 0.9,
        margin: EdgeInsets.all(18),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: selectedActivity == 1 ? AppColors.yellow : AppColors.crimson,
            boxShadow: [
              BoxShadow(
                color: AppColors.crimson,
                blurRadius: 2,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Colors.transparent,
              height: 150,
              width: 90,
              child: Image.asset("assets/books.jpg", fit: BoxFit.fill),
            ),
            PrimaryText(
                text: l10n.stories, fontWeight: FontWeight.w800, size: 25),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          selectedActivity = 1;
        });
        Navigator.pushNamed(context, AppRoute.pdfWatchScreen);
      },
    );
  }

  InkWell youtube(l10n) {
    return InkWell(
      child: Container(
        height: 125,
        width: ScreenSize(context).width * 0.9,
        margin: EdgeInsets.all(18),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: selectedActivity == 2 ? AppColors.yellow : AppColors.crimson,
            boxShadow: [
              BoxShadow(
                color: AppColors.crimson,
                blurRadius: 2,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Colors.transparent,
              height: 150,
              width: 90,
              child: Image.asset("assets/video.png", fit: BoxFit.fill),
            ),
            PrimaryText(
                text: l10n.videos, fontWeight: FontWeight.w800, size: 25),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          selectedActivity = 2;
        });
        Navigator.pushNamed(context, AppRoute.videoMainScreen);
      },
    );
  }

  InkWell games(l10n) {
    return InkWell(
      child: Container(
        height: 125,
        width: ScreenSize(context).width * 0.9,
        margin: EdgeInsets.all(18),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: selectedActivity == 0 ? AppColors.yellow : AppColors.crimson,
            boxShadow: [
              BoxShadow(
                color: AppColors.crimson,
                blurRadius: 2,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Colors.transparent,
              height: 150,
              width: 90,
              child: Image.asset("assets/games.png", fit: BoxFit.fill),
            ),
            PrimaryText(
                text: l10n.games, fontWeight: FontWeight.w800, size: 25),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          selectedActivity = 0;
        });
        Navigator.pushNamed(context, '/Games');
      },
    );
  }
}
