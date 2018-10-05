part of rest;

abstract class _ClientChatMixin implements _ClientWrapper {
  Future<Message> sendMessage(Message message) {
    Completer<Message> completer = Completer();
    http.post('${_getUrl()}/chat.sendMessage', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
      'Content-Type': 'application/json',
    }, body: json.encode(<String, dynamic>{
      'message': message,
    })).then((response) {
      final raw = json.decode(response.body)['message'];
      completer.complete(Message.fromJson(json.decode(raw)));
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }
}