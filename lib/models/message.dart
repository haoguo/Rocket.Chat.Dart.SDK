part of models;

@JsonSerializable()
class Message {
  Message();

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'rid')
  String roomId;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'editedBy', includeIfNull: false)
  String editedBy;

  @JsonKey(name: 'groupable', includeIfNull: false)
  bool groupable;

  @JsonKey(name: 'editedAt', includeIfNull: false)
  DateTime editedAt;

  @JsonKey(name: 'ts', includeIfNull: false, fromJson: _fromJsonToDateTime)
  DateTime timestamp;

  @JsonKey(name: 't')
  String type;

  @JsonKey(
      name: '_updatedAt', includeIfNull: false, fromJson: _fromJsonToDateTime)
  DateTime updatedAt;

  @JsonKey(name: 'mentions', includeIfNull: false)
  List<User> mentions;

  @JsonKey(name: 'u', includeIfNull: false)
  User user;

  @JsonKey(name: 'attachments', includeIfNull: false)
  List<Attachment> attachments;

  @JsonKey(includeIfNull: false)
  PostMessage postMessage;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class PostMessage {
  PostMessage();

  @JsonKey(includeIfNull: false)
  String roomId;
  @JsonKey(includeIfNull: false)
  String channel;
  @JsonKey(includeIfNull: false)
  String text;
  @JsonKey(includeIfNull: false)
  bool parseUrls;
  @JsonKey(includeIfNull: false)
  String alias;
  @JsonKey(includeIfNull: false)
  String emoji;
  @JsonKey(includeIfNull: false)
  String avatar;
  List<Attachment> attachments;

  factory PostMessage.fromJson(Map<String, dynamic> json) =>
      _$PostMessageFromJson(json);

  Map<String, dynamic> toJson() => _$PostMessageToJson(this);
}

@JsonSerializable()
class Attachment {
  Attachment();

  @JsonKey(includeIfNull: false)
  String color;
  @JsonKey(includeIfNull: false)
  String text;
  @JsonKey(includeIfNull: false)
  String timestamp;
  @JsonKey(includeIfNull: false)
  String thumbUrl;
  @JsonKey(includeIfNull: false)
  String messageLink;
  @JsonKey(includeIfNull: false)
  bool collapsed;

  @JsonKey(includeIfNull: false)
  String authorName;
  @JsonKey(includeIfNull: false)
  String authorLink;
  @JsonKey(includeIfNull: false)
  String authorIcon;

  @JsonKey(includeIfNull: false)
  String title;
  @JsonKey(includeIfNull: false)
  String titleLink;
  @JsonKey(includeIfNull: false)
  String titleLinkDownload;

  @JsonKey(includeIfNull: false)
  String imageUrl;
  @JsonKey(includeIfNull: false)
  String audioUrl;
  @JsonKey(includeIfNull: false)
  String videoUrl;

  @JsonKey(includeIfNull: false)
  List<AttachmentField> fields;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}

@JsonSerializable()
class AttachmentField {
  AttachmentField();

  bool short;
  String title;
  String value;

  factory AttachmentField.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFieldFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentFieldToJson(this);
}
