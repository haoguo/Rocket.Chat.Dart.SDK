part of realtime;

class UpdateEvent {
  String collection;
  String operation;
  String id;
  Map<String, dynamic> doc;
}

abstract class _ClientSubscriptionsMixin implements _DdpClientWrapper {
  Future<void> subRoomMessages(String name) {
    Completer<void> completer = Completer();
    this
        ._getDdpClient()
        .sub('stream-room-messages', [name, true])
        .then((call) => completer.complete(null))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Stream<UpdateEvent> roomMessages() {
    StreamController<UpdateEvent> controller = StreamController();
    this
        ._getDdpClient()
        .collectionByName('stream-room-messages')
        .addUpdateListener((String collection, String operation, String id,
            Map<String, dynamic> doc) {
      controller.add(UpdateEvent()
        ..collection = collection
        ..operation = operation
        ..id = id
        ..doc = doc);
    });
    return controller.stream;
  }
}
