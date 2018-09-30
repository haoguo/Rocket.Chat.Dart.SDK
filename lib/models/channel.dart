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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      '_id': this.id,
      'name': this.name,
      't': this.type,
      'msgs': this.msgs,
      'default': this.isDefault,
    };
    if (this.fName != null && this.fName.isNotEmpty) {
      map['fname'] = this.fName;
    }
    if (this.readOnly != null && !this.readOnly) {
      map['ro'] = this.readOnly;
    }
    if (this.sysMes != null && !this.sysMes) {
      map['sysMes'] = this.sysMes;
    }
    if (this.broadcast != null && !this.broadcast) {
      map['broadcast'] = this.broadcast;
    }
    if (this.timestamp != null) {
      map['ts'] = this.timestamp;
    }
    if (this.updatedAt != null) {
      map['_updatedAt'] = this.updatedAt;
    }
    if (this.user != null) {
      map['u'] = this.user;
    }
    if (this.lastMessage != null) {
      map['lastMessage'] = this.lastMessage;
    }
    return map;
  }
}

class ChannelSubscription {
  String id;
  bool alert;
  String name;
  String displayName;
  bool open;
  String roomId;
  String type;
  User user;
  List<String> roles;
  int unread;
}
