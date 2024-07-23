import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_v1/controller/local_language_controller.dart';
import 'package:project_v1/models/model_language.dart';
import 'package:project_v1/utils/app_consts.dart';
import 'package:provider/provider.dart';

class LanguageButtonWidget extends StatefulWidget {
  const LanguageButtonWidget({super.key});

  @override
  State<LanguageButtonWidget> createState() => _LanguageButtonWidgetState();
}

class _LanguageButtonWidgetState extends State<LanguageButtonWidget> {
  String? selectedItem ;
  @override
  void initState() {
    final provider = Provider.of<LocalLanguageController>(context,listen: false);
    selectedItem = provider.locale?.languageCode ?? "en";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalLanguageController>(context);
    final List<String> items = [
      'ar',
      'fr',
      'en',
    ];
    return DropdownButton<String>(
      underline: SizedBox(),
      icon: SizedBox(),
      value: selectedItem,
      onChanged: (String? value) {
        setState(() {
          selectedItem = value!;
        });
        provider.setLocale(Locale(value!));
      },
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Row(
            children: [
              SvgPicture.asset(
                'icons/' + item + ".svg",
                width: AppConsts.getHeight(context) * 0.04,
                height: AppConsts.getHeight(context) * 0.04,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
