import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_v1/helpers/fontHelper.dart';
import 'package:project_v1/helpers/gameWidget.dart';
import 'package:project_v1/helpers/model.dart';
import 'package:project_v1/helpers/myScarfold.dart';
import 'package:project_v1/helpers/starEffect.dart';
import 'package:project_v1/singletons/data_manager.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'dart:math' as Math;

typedef MyCustomBuilder = Widget Function(
  BuildContext context,
  Widget? child,
  dynamic value,
);

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late int _source_index;
  late PuzzleSource _puzzleSource;
  late Size size;

  late AnimationController animateCtrlCounter;
  late Animation<double> animation;
  double minGameWidthHeight = 0;

  ValueNotifier<int> counterNotifier = ValueNotifier<int>(-1);
  ValueNotifier<ActionControl> actionNotifier =
      ValueNotifier<ActionControl>(ActionControl.move);
  ValueNotifier<bool> completeNotifier = ValueNotifier<bool>(false);
  ValueNotifier<int> totalSplitNotifier = ValueNotifier<int>(3);

  GlobalKey<GameWidgetState_> key = GlobalKey();
  CarouselController buttonCarouselController = CarouselController();
  ValueNotifier<int> sourceIndexNotifier = ValueNotifier<int>(1);

  

  @override
  void dispose() {
    animation.removeListener(() {});
    counterNotifier.dispose();
    animateCtrlCounter.dispose();
    actionNotifier.dispose();
    completeNotifier.dispose();
    totalSplitNotifier.dispose();
    sourceIndexNotifier.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    initiateProcess();
    initiateAnimations();

    // TODO: implement initState
    super.initState();
  }

  initiateAnimations() {
    animateCtrlCounter = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    animation = Tween<double>(begin: 0, end: 1).animate(animateCtrlCounter);
  }

  void initiateProcess() {
    _source_index = 2;

    changePuzzleSource();
  }

  changePuzzleSource() {
    _puzzleSource = DataManager.puzzleSources![sourceIndexNotifier.value - 1];
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    double? min = Math.min(size.width - 50, size.height - 50);
    double? resizeScale = (min > 800 ? 1 : min / 800 * 1);
    Axis? axis = size.width >= size.height ? Axis.horizontal : Axis.vertical;
    Axis axisChild1 = axis == Axis.horizontal ? Axis.vertical : Axis.horizontal;

    return MyScaffold(
      body: StarEffect(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: ValueListenableBuilder(
              valueListenable: completeNotifier,
              builder: (context, bool complete, child) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Flex(
                          clipBehavior: Clip.antiAlias,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                         
                          direction: axis,
                          children: [
                            leftTab(resizeScale, axis, axisChild1),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    minGameWidthHeight = Math.min(
                                        Math.min(constraints.biggest.width,
                                            constraints.biggest.height),
                                        (500));

                                    print(
                                        "stat ${constraints.biggest} ${minGameWidthHeight}");

                                    return Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      constraints: BoxConstraints.loose(
                                          Size.square(minGameWidthHeight)),
                                      child: Stack(
                                        fit: StackFit.passthrough,
                                        children: [
                                         
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            margin:
                                                EdgeInsets.all(0 * resizeScale),
                                            child: GameWidget(
                                              _puzzleSource,
                                              key: key,
                                              size: Size.square(
                                                  minGameWidthHeight -
                                                      (0 * resizeScale) * 2),
                                              padding: 4 * resizeScale,
                                              durationPieceMove:
                                                  Duration(milliseconds: 300),
                                              totalSplit:
                                                  totalSplitNotifier.value,
                                              counterCallback: (int counter) {
                                                counterNotifier.value = counter;
                                                counterNotifier
                                                    .notifyListeners();

                                                animateCtrlCounter.reset();
                                                animateCtrlCounter.forward();
                                              },
                                              paddingOuter: resizeScale,
                                            ),
                                          ),
                                          ValueListenableBuilder(
                                            valueListenable: counterNotifier,
                                            builder:
                                                (context, int value, child) {
                                              String text = "";

                                              if (value == 4) {
                                                text = "Ready!";
                                              } else if (value > 0) {
                                                text = "$value";
                                              } else if (value == 0) {
                                                text = "Start!";
                                              }

                                              return Offstage(
                                                offstage: value < 0,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: double.maxFinite,
                                                  height: double.maxFinite,
                                                  color: Colors.black54,
                                                  child: AnimatedBuilder(
                                                    animation: animation,
                                                    builder: (context,
                                                        childAnimated) {
                                                      return Transform.scale(
                                                        scale: animation.value,
                                                        child: childAnimated,
                                                      );
                                                    },
                                                    child: FontHelper(
                                                      text,
                                                      sizeText:
                                                          150 * resizeScale,
                                                      color: Colors.white,
                                                      align: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            if (axis == Axis.horizontal)
                              rightTab(resizeScale, axis, axisChild1),
                            if (axis == Axis.vertical)
                              Flexible(
                                flex: 1,
                                child: Flex(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  direction: axis,
                                  children: [
                                    controlTab(resizeScale, complete),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    if (axis == Axis.horizontal)
                      controlTab(resizeScale, complete),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget listenerValueTotalSplit({required MyCustomBuilder builder}) {
    return ValueListenableBuilder(
      valueListenable: totalSplitNotifier,
      builder: (buildContext, int totalSplit, child) {
        return builder.call(buildContext, child, totalSplit);
      },
    );
  }

  Widget listenerValueIndexImage({required MyCustomBuilder builder}) {
    return ValueListenableBuilder(
      valueListenable: sourceIndexNotifier,
      builder: (buildContext, int sourceIndex, child) {
        return builder.call(buildContext, child, sourceIndex);
      },
    );
  }

  controlTab(double resizeScale, complete) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      child: Offstage(
        offstage: complete,
        child: Padding(
          padding: EdgeInsets.all(8.0 * resizeScale),
          child: ValueListenableBuilder(
            valueListenable: actionNotifier,
            builder: (context, ActionControl control, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FontHelper(
                    "Move".toUpperCase(),
                    fontFamily: FontClass.KidZone,
                    color: Colors.white,
                    sizeText: 40 * resizeScale,
                  ),
                  FlutterSwitch(
                    value: control.name == "rotate",
                    inactiveColor: Colors.transparent,
                    activeColor: Colors.transparent,
                    toggleColor: Color.fromARGB(255, 186, 149, 250),
                    toggleBorder: Border.all(width: 2, color: Colors.white),
                    switchBorder: Border.all(width: 2, color: Colors.white),
                    borderRadius: 50 * resizeScale,
                    height: 100 * resizeScale,
                    width: 200 * resizeScale,
                    toggleSize: 80 * resizeScale,
                    inactiveIcon: Image.asset(
                      "assets/images/move.png",
                    ),
                    activeIcon: Image.asset(
                      "assets/images/rotate.png",
                    ),
                    onToggle: (status) {
                      actionNotifier.value =
                          status ? ActionControl.rotate : ActionControl.move;
                      actionNotifier.notifyListeners();
                      key.currentState?.changeAction(actionNotifier.value);
                    },
                  ),
                  FontHelper(
                    "Rotate".toUpperCase(),
                    fontFamily: FontClass.KidZone,
                    color: Colors.white,
                    sizeText: 40 * resizeScale,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  leftTab(double resizeScale, axis, axisChild) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(20 * resizeScale),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: axis,
          children: [
        
            Container(
              width: (axis == Axis.horizontal ? 150 : size.width / 3 * 2),
              height: (axis == Axis.horizontal ? size.height / 3 * 2 : 150),
              child: CarouselSlider(
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                    initialPage: 0,
                    aspectRatio: 1,
                    viewportFraction: .4,
                    scrollDirection: axisChild,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      sourceIndexNotifier.value = index + 1;
                      sourceIndexNotifier.notifyListeners();
                      changePuzzleSource();
                      key.currentState!.updatePuzzleSource(_puzzleSource);
                    }),
                items: DataManager.puzzleSources!
                    .map((e) => Image.memory(
                          e.imageByte!,
                          width: 150 * resizeScale,
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  rightTab(double resizeScale, axis, axisChild1) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(20 * resizeScale),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: axis,
          children: [
            Flex(
              direction: axisChild1,
              children: [
                listenerValueTotalSplit(
                  builder: (context, child, value) {
                    return Column(
                      children: [
                        Container(
                          constraints: BoxConstraints.loose(
                              Size.square(100 * resizeScale)),
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: value.toInt(),
                              childAspectRatio: 1,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                            ),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: Math.pow(value.toInt(), 2).toInt(),
                            itemBuilder: (buildContext, index) {
                              return Container(
                                color: Colors.red,
                              );
                            },
                          ),
                        ),
                        Container(
                          child: FontHelper(
                            "${value.toInt()}x${value.toInt()}",
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
