part of rest;

abstract class _ClientGroupsMixin implements _ClientWrapper {
  Future<List<Message>> groupsLoadHistory(
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
    http.get('${_getUrl()}/groups.history?${query.toString()}', headers: {
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

  Future<Channel> groupsCreate(
    String name, {
    List<String> members = const [],
    bool readOnly = false,
  }) {
    Completer<Channel> completer = Completer();
    http
        .post('${_getUrl()}/groups.create',
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
      completer.complete(Channel.fromJson(json.decode(response.body)['group']));
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> groupsSetTopic(String roomId, String topic) {
    Completer<void> completer = Completer();
    http
        .post('${_getUrl()}/groups.setTopic',
            headers: {
              'X-User-Id': _auth._id,
              'X-Auth-Token': _auth._token,
              'Content-Type': 'application/json',
            },
            body: json.encode(<String, dynamic>{
              'roomId': roomId,
              'topic': topic,
            }))
        .then((response) {
      completer.complete(null);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<Channel> groupsInvite(String roomId, String userId) {
    Completer<Channel> completer = Completer();
    http
        .post('${_getUrl()}/groups.invite',
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
      completer.complete(Channel.fromJson(json.decode(response.body)['group']));
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<Channel> groupsKick(String roomId, String userId) {
    Completer<Channel> completer = Completer();
    http
        .post('${_getUrl()}/groups.kick',
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
      completer.complete(Channel.fromJson(json.decode(response.body)['group']));
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> groupsLeave(String roomId) {
    Completer<void> completer = Completer();
    http
        .post('${_getUrl()}/groups.leave',
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

  Future<List<User>> groupMembers(
    String roomId, {
    int offset,
    int count,
  }) {
    Completer<List<User>> completer = Completer();
    StringBuffer query = StringBuffer('roomId=$roomId');
    if (offset != null) {
      query.write('&offset=$offset');
    }
    if (count != null) {
      query.write('&count=$count');
    }
    http.get('${_getUrl()}/groups.members?${query.toString()}', headers: {
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

  Future<List<Channel>> listGroups() {
    Completer<List<Channel>> completer = Completer();
    http.get('${_getUrl()}/groups.list', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
    }).then((response) {
      _hackResponseHeader(response);
      final ims = json.decode(response.body)['groups'] as List;
      final list = ims.map<Channel>((im) => Channel.fromJson(im)).toList();
      completer.complete(list);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }
}
