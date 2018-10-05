part of models;

DateTime _TsFromJson(Map<String, dynamic> json) {
  if (json['ts'].runtimeType == String) {
    return DateTime.parse(json['ts'] as String);
  }
  return DateTime.fromMillisecondsSinceEpoch(json['ts']['\$date']);
}

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

  @JsonKey(name: 'ts', includeIfNull: false, fromJson: _TsFromJson)
  DateTime timestamp;

  @JsonKey(name: '_updatedAt', includeIfNull: false)
  DateTime updatedAt;

  @JsonKey(name: 'mentions', includeIfNull: false)
  List<User> mentions;

  @JsonKey(name: 'u', includeIfNull: false)
  User user;

  PostMessage postMessage;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
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

  Map<String, dynamic> toJson() => _$PostMessageToJson(this);
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
