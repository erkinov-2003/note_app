
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/storage.dart';

import '../user_model.dart';

class Users with ChangeNotifier {
  List<User> _users = [];
  List<User> get users => _users;
  late User currentUser;
  late bool isLogged;

  Future<void> getAllUser() async {
    String users = await $secureStorage.read(key: StorageKeys.users.key) ?? "[]";
    _users = List<String>.from(jsonDecode(users) as List).map((e) => User.fromJson(e)).toList();
  }

  Future<void> getOneUser() async {
    String user = (await $secureStorage.read(key: StorageKeys.oneUser.key))!;
    currentUser = User.fromMap((jsonDecode(user) as Map).cast<String, Object?>());
  }

  Future<void> setUsers() async {
    await getOneUser();
    _users.add(currentUser);
    await $secureStorage.write(key: StorageKeys.users.key, value: jsonEncode(_users.map((e) => e.toJson()).toList()));
  }

  Future<void> updateUser(User newUser) async {
   int index = _users.indexWhere((element) => element.id == newUser.id);
   _users[index] = newUser;
   currentUser = newUser;
   await $secureStorage.write(key: StorageKeys.users.key, value: jsonEncode(_users.map((e) => e.toJson()).toList()));
   await $secureStorage.write(key: StorageKeys.oneUser.key, value: currentUser.toJson());
   notifyListeners();
  }
}