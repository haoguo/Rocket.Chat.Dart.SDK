part of rest;

abstract class _ClientChatMixin implements _ClientWrapper {
  Future<Message> sendMessage(Message message) {
    Completer<Message> completer = Completer();
    http
        .post('${_getUrl()}/chat.sendMessage',
            headers: {
              'X-User-Id': _auth._id,
              'X-Auth-Token': _auth._token,
              'Content-Type': 'application/json',
            },
            body: json.encode(<String, dynamic>{
              'message': message,
            }))
        .then((response) {
      _hackResponseHeader(response);
      final raw = json.decode(response.body)['message'];
      completer.complete(Message.fromJson(raw));
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> reactMessage(String messageId, String emoji,
      [bool shouldReact]) {
    Completer<void> completer = Completer();
    final body = json.encode(<String, dynamic>{
      'messageId': messageId,
      'emoji': emoji,
      'shouldReact': shouldReact,
    });
    final headers = <String, String>{
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
      'Content-Type': 'application/json',
    };
    http
        .post('${_getUrl()}/chat.react', headers: headers, body: body)
        .then((response) => completer.complete(null))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }
}
