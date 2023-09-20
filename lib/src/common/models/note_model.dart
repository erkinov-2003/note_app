class NoteModel {
  String noteId;
  String userId;
  String? title;
  String? body;
  DateTime dateTime;
  String? image;
  List<String>? link;
  bool isSecret;

  NoteModel({
    required this.noteId,
    required this.userId,
    required this.dateTime,
    this.title,
    this.body,
    this.image,
    this.link,
    this.isSecret = false,
  });

  factory NoteModel.fromJson(Map<String, Object?> json) => NoteModel(
        noteId: json["noteId"] as String,
        userId: json["userId"] as String,
        title: json["title"] as String?,
        body: json["body"] as String?,
        dateTime: DateTime.parse(json["dateTime"] as String),
        image: json["image"] as String?,
        link: json["link"] != null
            ? List<String>.from(json["link"] as List)
            : null,
        isSecret: json["isSecret"] as bool,
      );

  Map<String, Object?> toJson() => {
        "noteId": noteId,
        "userId": userId,
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
      noteId: $noteId,
      userId:$userId,
      title: $title,
      body: $body,
      dateTime: $dateTime,
      image: $image,
      link: $link,
      isSecret: $isSecret,
    );
    """;
}
