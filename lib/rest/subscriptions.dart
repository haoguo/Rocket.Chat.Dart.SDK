part of rest;

abstract class _ClientSubscriptionsMixin implements _ClientWrapper {
  Future<List<ChannelSubscription>> getSubscriptions() {
    Completer<List<ChannelSubscription>> completer = Completer();
    http.get('${_getUrl()}/subscriptions.get', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
    }).then((response) {
      _hackResponseHeader(response);
      final rawRoomsList = json.decode(response.body)['update'] as List;
      final rooms = <ChannelSubscription>[];
      for (var raw in rawRoomsList) {
        rooms.add(ChannelSubscription.fromJson(raw));
      }
      completer.complete(rooms);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<ChannelSubscription> getSubscriptionsOne(String roomId) {
    Completer<ChannelSubscription> completer = Completer();
    http.get('${_getUrl()}/subscriptions.getOne?roomId=$roomId', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
    }).then((response) {
      _hackResponseHeader(response);
      final rawBody = json.decode(response.body)['subscription'];
      if (rawBody == null) {
        completer.complete(null);
      } else {
        final subscription = ChannelSubscription.fromJson(rawBody);
        completer.complete(subscription);
      }
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
