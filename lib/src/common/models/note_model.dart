import '../../features/create_note/models/link_model.dart';

class NoteModel {
  int noteId;
  String userId;
  String? title;
  List<LinkModel>? body;
  DateTime dateTime;
  String? image;
  List<String>? link;
  bool isSecret;

  NoteModel({
    required this.noteId,
    required this.userId,
    DateTime? dateTime,
    this.title,
    this.body,
    this.image,
    this.link,
    this.isSecret = false,
  }) : dateTime = dateTime ?? DateTime.now();

  factory NoteModel.fromJson(Map<String, Object?> json) => NoteModel(
        noteId: json["noteId"] as int,
        userId: json["userId"] as String,
        title: json["title"] as String?,
        body: json["body"] != null
            ? List<Map<String,Object?>>.from(json["body"] as List).map(LinkModel.fromJson).toList()
            : [],
        dateTime: DateTime.parse(json["dateTime"] as String),
        image: json["image"] as String?,
        link: json["link"] != null
            ? List<String>.from(json["link"] as List)
            : [],
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
      body: ${body?.map((e) => e.toString())},
      dateTime: $dateTime,
      image: $image,
      link: $link,
      isSecret: $isSecret,
    );
    """;


  NoteModel copyWith({
    int? noteId,
    String? userId,
    String? title,
    List<LinkModel>? body,
    String? image,
    List<String>? link,
    bool? isSecret,
  }) =>
      NoteModel(
        noteId: noteId ?? this.noteId,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        body: body ?? this.body,
        image: image ?? this.image,
        link: link ?? this.link,
        isSecret: isSecret ?? this.isSecret,
        dateTime: dateTime,
      );


}
