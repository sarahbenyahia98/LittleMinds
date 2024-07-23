// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String displayName;
  final String email;
  final String role;
  final String? age;
  final List<double>? values; //if user is child
  final List<String>? childs;
  final String password;
  final String? parentUid;
  UserModel({
    required this.id,
    required this.displayName,
    required this.email,
    required this.role,
    required this.age,
    this.values,
    this.childs,
    required this.password,
    this.parentUid,
  });

  UserModel copyWith({
    String? id,
    String? displayName,
    String? email,
    String? role,
    String? age,
    List<double>? values,
    List<String>? childs,
    String? password,
    String? parentUid,
  }) {
    return UserModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      role: role ?? this.role,
      age: age ?? this.age,
      values: values ?? this.values,
      childs: childs ?? this.childs,
      password: password ?? this.password,
      parentUid: parentUid ?? this.parentUid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'displayName': displayName,
      'email': email,
      'role': role,
      'age': age,
      'values': values,
      'childs': childs,
      'password': password,
      'parentUid': parentUid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      displayName: map['displayName'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      age: map['age'] != null ? map['age'] as String : null,
      values: map['values'] != null ? List<double>.from((map['values'])) : null,
      childs: map['childs'] != null ? List<String>.from((map['childs'])) : null,
      password: map['password'] as String,
      parentUid: map['parentUid'] != null ? map['parentUid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, displayName: $displayName, email: $email, role: $role, age: $age, values: $values, childs: $childs, password: $password, parentUid: $parentUid)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.displayName == displayName &&
        other.email == email &&
        other.role == role &&
        other.age == age &&
        listEquals(other.values, values) &&
        listEquals(other.childs, childs) &&
        other.password == password &&
        other.parentUid == parentUid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        displayName.hashCode ^
        email.hashCode ^
        role.hashCode ^
        age.hashCode ^
        values.hashCode ^
        childs.hashCode ^
        password.hashCode ^
        parentUid.hashCode;
  }
}
