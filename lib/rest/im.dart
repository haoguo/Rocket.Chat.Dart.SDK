part of rest;

abstract class _ClientIMMixin implements _ClientWrapper {
  Future<List<Message>> loadIMHistory(String roomId) {
    Completer<List<Message>> completer = Completer();
    http.get('${_getUrl()}/im.history?roomId=$roomId', headers: {
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

  Future<Channel> createIM(String username) {
    Completer<Channel> completer = Completer();
    http
        .post('${_getUrl()}/im.create',
            headers: {
              'X-User-Id': _auth._id,
              'X-Auth-Token': _auth._token,
              'Content-Type': 'application/json',
            },
            body: json.encode(<String, String>{
              'username': username,
            }))
        .then((response) {
      _hackResponseHeader(response);
      final channel = Channel.fromJson(json.decode(response.body)['room']);
      completer.complete(channel);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }
}
