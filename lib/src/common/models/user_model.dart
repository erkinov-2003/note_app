import 'dart:convert';

class User {
  final String? id;
  final String? name;
  final String? surname;
  final String? email;
  final String? loginPassword;
  final String? secretPassword;
  final String? image;

  User({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.loginPassword,
    this.secretPassword,
    this.image,
  });

  User copyWith({
    String? id,
    String? name,
    String? surname,
    String? email,
    final String? loginPassword,
    final String? secretPassword,
    String? image,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        loginPassword: loginPassword ?? this.loginPassword,
        secretPassword: secretPassword ?? this.secretPassword,
        image: image ?? this.image,
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
      );

  Map<String, Object?> toMap() => {
        "id": id,
        "name": name,
        "surname": surname,
        "email": email,
        "loginPassword": loginPassword,
        "secretPassword": secretPassword,
        "image": image,
      };
}
