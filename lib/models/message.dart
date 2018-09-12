part of models;

class Message {
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
}

class PostMessage {
  String roomId;
  String channel;
  String text;
  bool parseUrls;
  String alias;
  String emoji;
  String avatar;
  List<Attachment> attachments;
}

class Attachment {
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
}

class AttachmentField {
  bool short;
  String title;
  String value;
}