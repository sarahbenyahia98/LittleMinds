import 'package:flutter/material.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: AppConsts.getWidth(context),
      height: AppConsts.getHeight(context),
      decoration: BoxDecoration(
        color: AppColors.pale
      ),
      child: Column(children: [
        Spacer(),
        Text(l10n.loading,style: TextStyle(color: AppColors.black,fontSize: 20),),
        SizedBox(height: AppConsts.getHeight(context)*0.02,),
        CircularProgressIndicator(
          color: Colors.black54,
        ),
        Spacer()
      ],),
    );
  }
}