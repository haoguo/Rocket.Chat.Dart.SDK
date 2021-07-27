part of realtime;

abstract class _ClientEventsMixin implements _DdpClientWrapper {
  Future<void> startTyping(String roomId, String username, String token) {
    Completer<void> completer = Completer();
    this
        ._getDdpClient()
        .call('stream-notify-room', ['$roomId/typing', username, true, {'token': token}])
        .then((call) => completer.complete(null))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> stopTyping(String roomId, String username, String token) {
    Completer<void> completer = Completer();
    this
        ._getDdpClient()
        .call('stream-notify-room', ['$roomId/typing', username, false, {'token': token}])
        .then((call) => completer.complete(null))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }
}
