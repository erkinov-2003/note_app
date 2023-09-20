import 'dart:convert';

class User {
  final String? id;
  final String? name;
  final String? surname;
  final String? email;
  final String? password;
  final String? notePassword;
  final String? image;

  User({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.notePassword,
    this.image,
  });

  User copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
    String? password,
    String? notePassword,
    String? image,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        password: password ?? this.password,
        notePassword: notePassword ?? this.notePassword,
        image: image ?? this.image,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, Object?> json) => User(
    id: json["id"] as String?,
    name: json["name"] as String?,
    surname: json["surname"] as String?,
    email: json["email"] as String?,
    password: json["password"] as String?,
    notePassword: json["notePassword"] as String?,
    image: json["image"] as String?,
  );

  Map<String, Object?> toMap() => {
    "id": id,
    "name": name,
    "surname": surname,
    "email": email,
    "password": password,
    "notePassword": notePassword,
    "image": image,
  };
}