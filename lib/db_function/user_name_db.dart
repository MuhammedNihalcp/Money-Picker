import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_app/model/user_name_data_model.dart';

const userNameDBName = 'userNameDB';

abstract class UserNameDBFunction {
  Future<void> addName(UserNameModel value);
  // Future<List<UserNameModel>> getUserName();
  Future<void> updateName(UserNameModel value);
  Future<void> restratUserName();
}

class UserNameDB implements UserNameDBFunction {
  UserNameDB._internal();
  static UserNameDB instance = UserNameDB._internal();
  factory UserNameDB() {
    return instance;
  }
  late List<UserNameModel> nameList;
  ValueNotifier<UserNameModel> userNameNotifier =
      ValueNotifier(UserNameModel(username: ''));
  @override
  Future<void> addName(UserNameModel value) async {
    final userNameDB = await Hive.openBox<UserNameModel>(userNameDBName);
    userNameDB.put(value.id, value);
  }

  getUserName() async {
    final userNameDB = await Hive.openBox<UserNameModel>(userNameDBName);
    userNameNotifier.value = userNameDB.values.toList()[0];
  }

  @override
  Future<void> updateName(UserNameModel value) async {
    final userNameDB = await Hive.openBox<UserNameModel>(userNameDBName);
    userNameDB.put(value.id, value);
    getUserName();
  }

  @override
  Future<void> restratUserName() async {
    final userNameDB = await Hive.openBox<UserNameModel>(userNameDBName);
    userNameDB.clear();
  }
}
