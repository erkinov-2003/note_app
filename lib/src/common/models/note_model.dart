class NoteModel {
  String? title;
  String? body;
  DateTime dateTime;
  String? image;
  String? link;
  bool isSecret;

  NoteModel({
    required this.dateTime,
    this.title,
    this.body,
    this.image,
    this.link,
    this.isSecret = false,
  });

  factory NoteModel.fromJson(Map<String, Object?> json) => NoteModel(
        title: json["title"] as String?,
        body: json["body"] as String?,
        dateTime: DateTime.parse(json["dateTime"] as String),
        image: json["image"] as String?,
        link: json["link"] as String?,
        isSecret: json["isSecret"] as bool,
      );

  Map<String, Object?> toJson() => {
        "title": title,
        "body": body,
        "dateTime": dateTime.toUtc().toIso8601String(),
        "image": image,
        "link": link,
        "isSecret": isSecret,
      };

  @override
  String toString() => """
    NoteModel(
      title: $title,
      body: $body,
      dateTime: $dateTime,
      image: $image,
      link: $link,
      isSecret: $isSecret,
    );
    """;
}
