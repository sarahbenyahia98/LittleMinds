import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:project_v1/helpers/fontHelper.dart';
import 'package:project_v1/helpers/myScarfold.dart';
import 'package:project_v1/singletons/general_access.dart';
import 'package:project_v1/helpers/starEffect.dart';
import 'dart:math' as Math;

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  void initState() {
    initiateProcess();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double min = Math.min(size.width, size.height);
    double resizeScale = (min > 800 ? 1 : min / 800 * 1);
    Axis axis = size.width >= size.height ? Axis.horizontal : Axis.vertical;

    return MyScaffold(
      body: StarEffect(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: axis,
                  runSpacing: 50 * resizeScale,
                  spacing: 50 * resizeScale,
                  children: [
                    FadeIn(
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 800),
                      child: Transform.translate(
                        offset: Offset(-30 * resizeScale, 0),
                        child: Transform.rotate(
                          angle: -30 * Math.pi / 180,
                          child: Image.asset(
                            "assets/images/rocket2.png",
                            fit: BoxFit.contain,
                            height: 180 * resizeScale,
                          ),
                        ),
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.vertical,
                      children: [
                        BounceInDown(
                          delay: const Duration(milliseconds: 800),
                          from: 200,
                          duration: const Duration(milliseconds: 800),
                          child: Image.asset(
                            "assets/images/logo1.png",
                            width: 150 * resizeScale,
                            colorBlendMode: BlendMode.color,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 800),
                          from: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: FontHelper(
                              "Little Minds",
                              color: Color.fromARGB(255, 247, 119, 0),
                              sizeText: 35 * resizeScale,
                              fontFamily: FontClass.Random,
                              strokeColor: Color.fromARGB(255, 255, 255, 255),
                              shadowColor: const Color.fromARGB(255, 0, 0, 0),
                              shadowOffset: const Offset(0, 1),
                              showStroke: true,
                              align: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initiateProcess() {
    GeneralAccess();

    GeneralAccess.initiateAccess(context);
  }
}
