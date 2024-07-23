import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_v1/models/user_model.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:project_v1/widgets/line_chart_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ParentStatesticPage extends StatelessWidget {
  const ParentStatesticPage({super.key, required this.users});
  final List<UserModel> users;
  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          header(context),
          Column(
              children: users.map((UserModel user) {
            return body(context, user: user,l10n: l10n);
          }).toList())
        ],
      )),
    );
  }

  Widget header(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: AppConsts.getWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          statesticHeader(context, value: users.length, text: l10n.child_number),
          statesticHeader(context,
              value: users.last.values!.last.toInt(), text: l10n.best_score),
        ],
      ),
    );
  }

  Widget statesticHeader(BuildContext context,
      {required int value, required String text}) {
    return Card(
      color: AppColors.backGround,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: AppConsts.getWidth(context) * 0.4,
        height: AppConsts.getHeight(context) * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "$value",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

Widget body(BuildContext context, {required UserModel user,required AppLocalizations l10n}) {
  var step = 0.0;
  return Container(
      margin: EdgeInsets.only(top: AppConsts.getHeight(context) * 0.03),
      width: AppConsts.getWidth(context),
      child: Column(
        children: [
          Text(
            l10n.child_name+" " + user.displayName,
            style: TextStyle(fontSize: 16),
          ),
          LineChartSample2(
            list: user.values?.map((toElement) {
                  step += 1;
                  return FlSpot(step, toElement); //todo
                }).toList() ??
                [],
          ),
        ],
      ));
}
