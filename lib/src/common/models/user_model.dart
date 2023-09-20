class User {
  final String name;
  final String email;
  final String loginPassword;
  final String? secretPassword;

  User({
    required this.name,
    required this.email,
    required this.loginPassword,
    this.secretPassword,
  });

  Map<String, Object?> toJson() {
    return <String, Object?>{
      "name": name,
      "email": email,
      "loginPassword": loginPassword,
      "secretPassword": secretPassword,
    };
  }

  factory User.fromJson(Map<String, Object?> json) => User(
        name: json["name"] as String,
        email: json["email"] as String,
        loginPassword: json["loginPassword"] as String,
        secretPassword: json["secretPassword"] != null
            ? json["secretPassword"] as String
            : null,
      );

  User copyWith({
    String? name,
    String? loginPassword,
    String? secretPassword,
    String? email,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      loginPassword: loginPassword ?? this.loginPassword,
      secretPassword: secretPassword ?? this.secretPassword,
    );
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, loginPassword: $loginPassword, secretPassword: $secretPassword}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          loginPassword == other.loginPassword &&
          secretPassword == other.secretPassword;

  @override
  int get hashCode =>
      name.hashCode ^
      email.hashCode ^
      loginPassword.hashCode ^
      secretPassword.hashCode;
}
