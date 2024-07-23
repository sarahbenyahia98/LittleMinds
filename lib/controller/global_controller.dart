import 'package:flutter/material.dart';
import 'package:project_v1/models/role_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController with ChangeNotifier {
  RoleEnum role = RoleEnum.none;
  bool isLoading = false;
  int indexParent = 0;
  int indexAdmin=0;
  String kidId = "";

  void onChangeKidId({required String value}) {
    kidId = value;
    notifyListeners();
  }

  void onChangeRole(RoleEnum role) async {
    final prefs = await SharedPreferences.getInstance();
    this.role = role;
    await prefs.setInt("role", role.index);
    notifyListeners();
  }

  Future<RoleEnum> ongetRole() async {
    final prefs = await SharedPreferences.getInstance();
    int roleIndex = prefs.getInt("role") ?? 0;
    switch (roleIndex) {
      case 1:
        role = RoleEnum.Admin;
      case 2:
        role = RoleEnum.Parent;
      case 3:
        role = RoleEnum.Child;
      default:
        role = RoleEnum.none;
    }
    return role;
  }

  void onChangeIndex(int index) {
    this.indexParent = index;
    notifyListeners();
  }

  void onChangeAdminIndex(int index) {
    this.indexAdmin = index;
    notifyListeners();
  }

  void onChangeLoading(bool value) {
    this.isLoading = value;
    notifyListeners();
  }
}
