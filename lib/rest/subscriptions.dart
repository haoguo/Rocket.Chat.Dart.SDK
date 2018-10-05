part of rest;

abstract class _ClientSubscriptionsMixin implements _ClientWrapper {
  Future<List<Channel>> getSubscriptions() {
    Completer<List<Channel>> completer = Completer();
    http.get('${_getUrl()}/subscriptions.get', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
    }).then((response) {
      final rawRoomsList = json.decode(response.body)['update'] as List;
      final rooms = <Channel>[];
      for (var raw in rawRoomsList) {
        rooms.add(Channel.fromJson(raw));
      }
      completer.complete(rooms);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> markAsRead(String rid) {
    Completer<void> completer = Completer();
    http
        .post('${_getUrl()}/subscriptions.read',
            headers: {
              'X-User-Id': _auth._id,
              'X-Auth-Token': _auth._token,
              'Content-Type': 'application/json',
            },
            body: json.encode(<String, String>{'rid': rid}))
        .then((response) => completer.complete(null))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }
}
