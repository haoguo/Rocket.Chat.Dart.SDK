part of realtime;

abstract class _ClientLiveChatMixin extends _DdpClientWrapper {
  Future<dynamic> getInitialDataLiveChat(String token) {
    Completer<dynamic> completer = Completer();
    this
        ._getDdpClient()
        .call('livechat:getInitialData', [token])
        .then((call) => completer.complete(call.reply))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<dynamic> registerGuestLiveChat(String token, String name, {String email, String department}) {
    Completer<dynamic> completer = Completer();
    this
        ._getDdpClient()
        .call('livechat:registerGuest', [
          <String, dynamic>{
            'token': token,
            'name': name,
            'email': email,
            'department': department
          },
        ])
        .then((call) => completer.complete(call.reply))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<Message> sendMessageLiveChat(String roomId, String token, String text, {String id}) {
    Completer<Message> completer = Completer();
    final message = Message()
      ..roomId = roomId
      ..msg = text
      ..token = token
      ..id = id != null ? id : _randomId();
    this
        ._getDdpClient()
        .call('sendMessageLivechat', [message])
        .then((call) => completer.complete(Message.fromJson(call.reply)))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<String> subRoomLiveChat(String name, String token) {
    Completer<String> completer = Completer();
    this
        ._getDdpClient()
        .sub('stream-livechat-room', [
          name,
          <String, dynamic>{
            'useCollection': true,
            'args': [<String, dynamic>{
              'token': token,
              'visitorToken': token
            }],
          },
        ])
        .then((call) => completer.complete(call.id))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }
}