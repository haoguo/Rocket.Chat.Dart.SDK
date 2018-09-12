part of realtime;

abstract class _ClientChannelsMixin implements _DdpClientWrapper {
  Future<String> getChannelId(String name) {
    Completer<String> completer = Completer();
    this._getDdpClient().call('getRoomIdByNameOrId', [name])
        .then((call) => completer.complete(call.reply as String))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<List<Channel>> getChannelsIn() {
    Completer<List<Channel>> completer = Completer();
    Map<String, dynamic> arg = {"\$date": 0};
    this._getDdpClient().call('rooms/get', [arg]);
    return completer.future;
  }
}