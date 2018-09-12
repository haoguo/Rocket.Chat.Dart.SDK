part of models;

class Channel {
  String id;
  String name;
  String fName;
  String type;
  int msgs;

  bool readOnly;
  bool sysMes;
  bool isDefault;
  bool broadcast;

  DateTime timestamp;
  DateTime updatedAt;

  User user;
  Message lastMessage;
}