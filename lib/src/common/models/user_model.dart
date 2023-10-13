import 'dart:convert';


import 'package:uuid/uuid.dart';

import '../../features/home_screen/controller/notes.dart';

class User {
  final String? id;
  final String? name;
  final String? surname;
  final String? email;
  String? loginPassword;
  final String? secretPassword;
  final String? image;
  final Notes? notes;

  User({
    String? id,
    this.name,
    this.surname,
    this.email,
    this.loginPassword,
    this.secretPassword,
    this.image,
    this.notes,
  }) : id = id ?? uuid.v4();

  static const uuid = Uuid();

  @override
  String toString() {
    return 'User{id: $id, name: $name, surname: $surname, email: $email, loginPassword: $loginPassword, secretPassword: $secretPassword, image: $image, notes:$notes}';
  }

  User copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
    String? loginPassword,
    String? secretPassword,
    String? image,
    Notes? notes,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        loginPassword: loginPassword ?? this.loginPassword,
        secretPassword: secretPassword ?? this.secretPassword,
        image: image ?? this.image,
        notes: notes ?? this.notes,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, Object?> json) => User(
        id: json["id"] as String?,
        name: json["name"] as String?,
        surname: json["surname"] as String?,
        email: json["email"] as String?,
        loginPassword: json["loginPassword"] as String?,
        secretPassword: json["secretPassword"] as String?,
        image: json["image"] as String?,
        notes: json["notes"] != null
            ? Notes.fromJson((json["notes"] as Map).cast<String, Object?>())
            : null,
      );

  Map<String, Object?> toMap() => {
        "id": id,
        "name": name,
        "surname": surname,
        "email": email,
        "loginPassword": loginPassword,
        "secretPassword": secretPassword,
        "image": image,
        "notes":notes?.toJson(),
      };
}
