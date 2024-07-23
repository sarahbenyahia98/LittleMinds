import 'package:flutter/material.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.controller,
      required this.name,
      required this.textInputType,
      required this.textInputAction, this.isPassword=false,this.isId=false});
  final TextEditingController controller;
  final String name;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool isPassword;
  final bool isId;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: AppConsts.getWidth(context) * 0.8,
      child: TextFormField(
        readOnly: isId,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          label: Text(name,style: TextStyle(fontSize: 15,color: Colors.black),),
           focusColor: Colors.amber,
           fillColor: Colors.red,
           hintText: name,
           hintStyle: TextStyle(fontSize: 14,color: Colors.black),
           focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.all(Radius.circular(20))),
           enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return l10n.enter_your + name;
          } else {
            return null;
          }
        },
      ),
    );
  }
}
