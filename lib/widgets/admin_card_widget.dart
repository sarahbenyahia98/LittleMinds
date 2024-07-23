import 'package:flutter/material.dart';

import 'package:project_v1/models/user_model.dart';

import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class KidCardWidget extends StatelessWidget {
  const KidCardWidget({super.key, required this.adminModel, required this.onDelete});
  final UserModel adminModel;

  final Function() onDelete;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
          color: AppColors.tale,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: AppConsts.getHeight(context) * 0.1,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title:  SizedBox(
          width: AppConsts.getWidth(context)*0.5,
          child: Text(
          adminModel.displayName,
          overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: SizedBox(
          width: AppConsts.getWidth(context)*0.5,
          child: Text(
            adminModel.email,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, color: Colors.teal),
          ),
        ),
        trailing: SizedBox(
          width: AppConsts.getWidth(context) * 0.3,
          child: Row(
            children: [
              Spacer(
                flex: 3,
              ),
              Text(
                l10n.kid,
                style: TextStyle(fontSize: 15, color: Colors.blueGrey),
              ),
              Spacer(),
              
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 20,
                ),
              ),
              SizedBox(
                width: AppConsts.getWidth(context) * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
