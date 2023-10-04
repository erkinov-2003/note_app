import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_app/src/common/utils/storage.dart';
import 'package:note_app/src/features/home_screen/controller/notes.dart';

import '../user_model.dart';

class Users with ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;
  late User currentUser;
  late bool isLogged;

  Future<void> getAllUser() async {
    String users =
        await $secureStorage.read(key: StorageKeys.users.key) ?? "[]";
    _users = List<String>.from(jsonDecode(users) as List)
        .map((e) => User.fromJson(e))
        .toList();
  }

  Future<void> getOneUser() async {
    String user = (await $secureStorage.read(key: StorageKeys.oneUser.key))!;
    currentUser =
        User.fromMap((jsonDecode(user) as Map).cast<String, Object?>());
  }

  Future<void> setUsers() async {
    _users.add(currentUser);
    await $secureStorage.write(
        key: StorageKeys.users.key,
        value: jsonEncode(_users.map((e) => e.toJson()).toList()));
  }

  Future<void> updateUser(User newUser) async {
    int index = _users.indexWhere((element) => element.id == newUser.id);
    _users[index] = newUser;
    currentUser = newUser;
    await $secureStorage.write(
        key: StorageKeys.users.key,
        value: jsonEncode(_users.map((e) => e.toJson()).toList()));
    await $secureStorage.write(
        key: StorageKeys.oneUser.key, value: currentUser.toJson());
    notifyListeners();
  }

  Future<void> updatePassword({required String email,required String password}) async {
    int index = _users.indexWhere((element) => element.email == email);
    _users[index].loginPassword = password;
    await $secureStorage.write(
        key: StorageKeys.users.key,
        value: jsonEncode(_users.map((e) => e.toJson()).toList()));
    notifyListeners();
  }

  Future<Status> checkLogin({
    required String email,
    required String password,
  }) async {
    int index = _users.indexWhere((element) => element.email == email);
    if (index == -1) {
      return Status.notLogged;
    } else {
      User user = _users.elementAt(index);
      if (user.loginPassword == password) {
        currentUser = user;
        await currentUser.notes?.setAllNotes();
        await $secureStorage.write(
            key: StorageKeys.oneUser.key, value: currentUser.toJson());
        $storage.setBool("isLogged", true);
        return Status.logged;
      } else {
        return Status.wrongPassword;
      }
    }
  }

  Future<void> checkRegistration({
    required String name,
    required String email,
    required String password,
  }) async {
    User user = User(
      name: name,
      email: email,
      loginPassword: password,
      notes: Notes(),
    );
    currentUser = user;
    await $secureStorage.write(
      key: StorageKeys.oneUser.key,
      value: currentUser.toJson(),
    );
    await setUsers();
    $storage.setBool("isLogged", true);
    notifyListeners();
  }
}

enum Status {
  logged,
  notLogged,
  wrongPassword,
}
