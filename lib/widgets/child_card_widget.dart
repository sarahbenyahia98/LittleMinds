import 'package:flutter/material.dart';
import 'package:project_v1/models/user_model.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:project_v1/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ChildCardWidget extends StatelessWidget {
  const ChildCardWidget({super.key, required this.kidModel, required this.onEdit, required this.onDelete});
  final UserModel kidModel;
  final Function() onEdit;
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
        title: Text(
          kidModel.displayName.toUpperCase(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          kidModel.age.toString() + " "+l10n.years,
          style: TextStyle(fontSize: 15, color: Colors.teal),
        ),
        trailing: SizedBox(
          width: AppConsts.getWidth(context) * 0.4,
          child: Row(
            children: [
              Spacer(
                flex: 3,
              ),
              Text(
                (kidModel.values?.last??0).toStringAsFixed(0),
                style: TextStyle(fontSize: 20, color: Colors.blueGrey),
              ),
              Spacer(),
              GestureDetector(
                onTap: onEdit,
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: 25,
                ),
              ),
              SizedBox(
                width: AppConsts.getWidth(context) * 0.03,
              ),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 25,
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
