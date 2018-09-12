part of realtime;

abstract class _ClientEmojiMixin implements _DdpClientWrapper {
  Future<void> getCustomEmoji() {
    Completer<void> completer = Completer();
    this
        ._getDdpClient()
        .call('listEmojiCustom', [])
        .then((value) => completer.complete(null))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }
}
