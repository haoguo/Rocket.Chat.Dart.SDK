part of realtime;

abstract class _ClientMessagesMixin implements _DdpClientWrapper {
  //https://rocket.chat/docs/developer-guides/realtime-api/method-calls/load-history/
  // timestamp: The NEWEST message timestamp date (or null) to only retrieve messages before this time. - this is used to do pagination
  // quantity: message quantity
  // dateobject: the date of the last time the client got data for the room (?)
  Future<RoomMessageHistory> loadHistory(
    String roomId, {
    DateTime timestamp,
    int quantity,
  }) {
    Completer<RoomMessageHistory> completer = Completer();
    this
        ._getDdpClient()
        .call('loadHistory', [
          roomId,
          timestamp != null ? DateTimeToMap(timestamp) : null,
          quantity
        ])
        .then((call) =>
            completer.complete(RoomMessageHistory.fromJson(call.reply)))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<Message> sendMessage(Channel channel, String text) {
    Completer<Message> completer = Completer();
    final message = Message()
      ..id = _randomId()
      ..roomId = channel.id
      ..msg = text;
    this
        ._getDdpClient()
        .call('sendMessage', [message])
        .then((call) => Message())
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> editMessage(Message message) {
    Completer<void> completer = Completer();
    this
        ._getDdpClient()
        .call('updateMessage', [message])
        .then((call) => completer.complete(call))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> deleteMessage(Message message) {
    Completer<void> completer = Completer();
    this
        ._getDdpClient()
        .call('deleteMessage', [
          <String, String>{'_id': message.id},
        ])
        .then((call) => completer.complete(call))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> starMessage(Message message) {
    Completer<void> completer = Completer();
    this
        ._getDdpClient()
        .call('starMessage', [
          <String, dynamic>{
            '_id': message.id,
            'rid': message.roomId,
            'starred': true,
          },
        ])
        .then((call) => completer.complete(call))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> unStarMessage(Message message) {
    Completer<void> completer = Completer();
    this
        ._getDdpClient()
        .call('starMessage', [
          <String, dynamic>{
            '_id': message.id,
            'rid': message.roomId,
            'starred': false,
          },
        ])
        .then((call) => completer.complete(call))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> pinMessage(Message message) {
    Completer<void> completer = Completer();
    this
        ._getDdpClient()
        .call('pinMessage', [message])
        .then((call) => completer.complete(call))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> unPinMessage(Message message) {
    Completer<void> completer = Completer();
    this
        ._getDdpClient()
        .call('unpinMessage', [message])
        .then((call) => completer.complete(call))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }
}
