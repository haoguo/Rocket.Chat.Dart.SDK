part of models;

@JsonSerializable()
class RoomMessageHistory {
  RoomMessageHistory();

  @JsonKey(name: 'unreadNotLoaded')
  int unreadNotLoaded;

  @JsonKey(name: 'messages')
  List<Message> messages;

  factory RoomMessageHistory.fromJson(Map<String, dynamic> json) =>
      _$RoomMessageHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$RoomMessageHistoryToJson(this);
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
  User editedBy;

  @JsonKey(name: 'groupable', includeIfNull: false)
  bool groupable;

  @JsonKey(
      name: 'editedAt', includeIfNull: false, fromJson: _fromJsonToDateTime)
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

  @JsonKey(name: 'reactions', includeIfNull: false)
  Map<String, ReactionItem> reactions;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class ReactionItem {
  ReactionItem();

  @JsonKey(name: 'usernames')
  List<String> usernames;

  factory ReactionItem.fromJson(Map<String, dynamic> json) =>
      _$ReactionItemFromJson(json);
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
  @JsonKey(name: 'ts', includeIfNull: false, fromJson: _fromJsonToDateTime)
  DateTime timestamp;
  @JsonKey(name: 'thumb_url', includeIfNull: false)
  String thumbUrl;
  @JsonKey(name: 'message_link', includeIfNull: false)
  String messageLink;
  @JsonKey(includeIfNull: false)
  bool collapsed;

  @JsonKey(name: 'author_name', includeIfNull: false)
  String authorName;
  @JsonKey(name: 'author_link', includeIfNull: false)
  String authorLink;
  @JsonKey(name: 'author_icon', includeIfNull: false)
  String authorIcon;

  @JsonKey(includeIfNull: false)
  String title;
  @JsonKey(name: 'title_link', includeIfNull: false)
  String titleLink;
  @JsonKey(name: 'title_link_download', includeIfNull: false)
  bool titleLinkDownload;

  @JsonKey(name: 'image_url', includeIfNull: false)
  String imageUrl;
  @JsonKey(name: 'audio_url', includeIfNull: false)
  String audioUrl;
  @JsonKey(name: 'video_url', includeIfNull: false)
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
