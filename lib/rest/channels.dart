part of rest;

@JsonSerializable()
class ChannelsResponse {
  ChannelsResponse();

  @JsonKey(name: 'channels')
  List<Channel> channels;

  factory ChannelsResponse.fromJson(Map<String, dynamic> json) =>
      _$ChannelsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelsResponseToJson(this);
}

abstract class _ClientChannelsMixin implements _ClientWrapper {
  Future<List<Channel>> getPublicChannels() {
    Completer<List<Channel>> completer = Completer();
    http.get('${_getUrl()}/channels.list', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
    }).then((response) {
      _hackResponseHeader(response);
      final channelsResponse =
          ChannelsResponse.fromJson(json.decode(response.body));
      completer.complete(channelsResponse.channels);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<List<Channel>> getPublicChannelsJoined() {
    Completer<List<Channel>> completer = Completer();
    http.get('${_getUrl()}/channels.list.joined', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
    }).then((response) {
      _hackResponseHeader(response);
      final channelsResponse =
          ChannelsResponse.fromJson(json.decode(response.body));
      completer.complete(channelsResponse.channels);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<Channel> channelsCreate(
    String name, {
    List<String> members = const [],
    bool readOnly = false,
  }) {
    Completer<Channel> completer = Completer();
    http
        .post('${_getUrl()}/channels.create',
            headers: {
              'X-User-Id': _auth._id,
              'X-Auth-Token': _auth._token,
              'Content-Type': 'application/json',
            },
            body: json.encode(<String, dynamic>{
              'name': name,
              'members': members,
              'readOnly': readOnly,
            }))
        .then((response) {
      _hackResponseHeader(response);
      completer
          .complete(Channel.fromJson(json.decode(response.body)['channel']));
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<List<Message>> channelsHistory(
    String roomId, {
    DateTime latest,
    DateTime oldest,
    bool inclusive,
    int count,
    bool unreads,
  }) {
    Completer<List<Message>> completer = Completer();
    StringBuffer query = StringBuffer('roomId=$roomId');
    if (latest != null) {
      query.write('&latest=${latest.toUtc().toIso8601String()}');
    }
    if (oldest != null) {
      query.write('&oldest=${oldest.toUtc().toIso8601String()}');
    }
    if (inclusive != null) {
      query.write('&inclusive=$inclusive');
    }
    if (count != null) {
      query.write('&count=$count');
    }
    if (unreads != null) {
      query.write('&unreads=$unreads');
    }
    http.get('${_getUrl()}/channels.history?${query.toString()}', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
    }).then((response) {
      _hackResponseHeader(response);
      final raws = json.decode(response.body)['messages'];
      final results = <Message>[];
      for (var raw in raws) {
        results.add(Message.fromJson(raw));
      }
      completer.complete(results);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<Channel> channelsInvite(String roomId, String userId) {
    Completer<Channel> completer = Completer();
    http
        .post('${_getUrl()}/channels.invite',
            headers: {
              'X-User-Id': _auth._id,
              'X-Auth-Token': _auth._token,
              'Content-Type': 'application/json',
            },
            body: json.encode(<String, dynamic>{
              'roomId': roomId,
              'userId': userId,
            }))
        .then((response) {
      _hackResponseHeader(response);
      completer
          .complete(Channel.fromJson(json.decode(response.body)['channel']));
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<Channel> channelsKick(String roomId, String userId) {
    Completer<Channel> completer = Completer();
    http
        .post('${_getUrl()}/channels.kick',
            headers: {
              'X-User-Id': _auth._id,
              'X-Auth-Token': _auth._token,
              'Content-Type': 'application/json',
            },
            body: json.encode(<String, dynamic>{
              'roomId': roomId,
              'userId': userId,
            }))
        .then((response) {
      _hackResponseHeader(response);
      completer
          .complete(Channel.fromJson(json.decode(response.body)['channel']));
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> channelsLeave(String roomId) {
    Completer<void> completer = Completer();
    http
        .post('${_getUrl()}/channels.leave',
            headers: {
              'X-User-Id': _auth._id,
              'X-Auth-Token': _auth._token,
              'Content-Type': 'application/json',
            },
            body: json.encode(<String, dynamic>{
              'roomId': roomId,
            }))
        .then((response) {
      _hackResponseHeader(response);
      completer.complete((void val) => completer.complete(null));
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> channelsOpen(String roomId) {
    Completer<void> completer = Completer();
    http
        .post('${_getUrl()}/channels.open',
            headers: {
              'X-User-Id': _auth._id,
              'X-Auth-Token': _auth._token,
              'Content-Type': 'application/json',
            },
            body: json.encode(<String, dynamic>{'roomId': roomId}))
        .then((response) => completer.complete(null))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> channelsClose(String roomId) {
    Completer<void> completer = Completer();
    final headers = {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
      'Content-Type': 'application/json',
    };
    final body = json.encode(<String, dynamic>{'roomId': roomId});
    http.post('${_getUrl()}/channelsClose', headers: headers, body: body)
      .then((response) => completer.complete(null))
      .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<List<User>> channelMembers({
    String roomId,
    String roomName,
    int offset,
    int count,
  }) {
    Completer<List<User>> completer = Completer();
    StringBuffer query;
    if (roomId != null) {
      query = StringBuffer('roomId=$roomId');
    } else if (roomName != null) {
      query = StringBuffer('roomName=$roomName');
    } else {
      completer
          .completeError('RoomId And RoomName cannot be null at the same time');
    }
    if (offset != null) {
      query.write('&offset=$offset');
    }
    if (count != null) {
      query.write('&count=$count');
    }
    http.get('${_getUrl()}/channels.members?${query.toString()}', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
    }).then((response) {
      _hackResponseHeader(response);
      final rawResponse = json.decode(response.body);
      final users = (rawResponse['members'] as List)
          .map<User>((u) => User.fromJson(u))
          .toList();
      completer.complete(users);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }
}
