import 'package:flutter/material.dart';
import 'package:project_v1/controller/local_language_controller.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int selectedCard = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.backGround),
        ),
        title: Image.asset('assets/images/Logo_color.png',
            width: 120, height: 120),
      ),
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildCards(context),
              Container(
                height: 120,
                width: ScreenSize(context).width,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset("assets/gamesFooter.png"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardsStyle(String imagePath, String name, int index) {
    return InkWell(
      onTap: () => {
        setState(
          () {
            selectedCard = index;
            Navigator.pushNamed(
                context, gamesRoutes[index]['routePath'].toString());
          },
        ),
      },
      child: Container(
        height: 100,
        width: ScreenSize(context).width * 0.9,
        margin: EdgeInsets.only(right: 20, top: 20, bottom: 20, left: 20),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: selectedCard == index ? AppColors.crimson : AppColors.yellow,
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
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
            PrimaryText(text: name, fontWeight: FontWeight.w800, size: 25),
          ],
        ),
      ),
    );
  }

  SizedBox buildCards(BuildContext context) {
    LocalLanguageController provider = Provider.of(context, listen: false);
    return SizedBox(
      height: ScreenSize(context).height,
      child: ListView.builder(
        itemCount: GamesList.length,
        itemBuilder: (BuildContext context, int index) {
          return cardsStyle(GamesList[index]['imagePath'].toString(),
              GamesList[index][provider.locale?.languageCode??'en'].toString(), index);
        },
      ),
    );
  }
}
