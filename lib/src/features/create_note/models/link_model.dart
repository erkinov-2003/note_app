class LinkModel {
  final String name;
  final String? link;

  LinkModel({
    required this.name,
    this.link,
  });

  factory LinkModel.fromJson(Map<String, Object?> json) => LinkModel(
        name: json["name"] as String,
        link: json["link"] != null ? json["link"] as String : null,
      );

  Map<String, Object?> toJson() => {
        "name": name,
        "link": link,
      };

  @override
  String toString() {
    return 'LinkModel{name: $name, link: $link}';
  }
}
