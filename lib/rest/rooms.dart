part of rest;

abstract class _ClientRoomsMixin implements _ClientWrapper {
  Future<List<Channel>> getRooms() {
    Completer<List<Channel>> completer = Completer();
    http.get('${_getUrl()}/rooms.get', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
    }).then((response) {
      _hackResponseHeader(response);
      final rawRoomsList = json.decode(response.body)['update'] as List;
      final rooms = <Channel>[];
      for (var raw in rawRoomsList) {
        rooms.add(Channel.fromJson(raw));
      }
      completer.complete(rooms);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }
}
