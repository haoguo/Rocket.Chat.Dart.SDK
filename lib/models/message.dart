part of models;

@JsonSerializable()
class Message {
  Message();

  String id;
  String roomId;
  String msg;
  String editedBy;
  bool groupable;
  DateTime editedAt;
  DateTime timestamp;
  DateTime updatedAt;
  List<User> mentions;
  User user;

  PostMessage postMessage;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@JsonSerializable()
class PostMessage {
  PostMessage();

  String roomId;
  String channel;
  String text;
  bool parseUrls;
  String alias;
  String emoji;
  String avatar;
  List<Attachment> attachments;

  factory PostMessage.fromJson(Map<String, dynamic> json) =>
      _$PostMessageFromJson(json);
}

@JsonSerializable()
class Attachment {
  Attachment();

  String color;
  String text;
  String timestamp;
  String thumbUrl;
  String messageLink;
  bool collapsed;

  String authorName;
  String authorLink;
  String authorIcon;

  String title;
  String titleLink;
  String titleLinkDownload;

  String imageUrl;
  String audioUrl;
  String videoUrl;

  List<AttachmentField> fields;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}

@JsonSerializable()
class AttachmentField {
  AttachmentField();

  bool short;
  String title;
  String value;

  factory AttachmentField.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFieldFromJson(json);
}
