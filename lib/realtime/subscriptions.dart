part of realtime;

class UpdateEvent {
  String collection;
  String operation;
  String id;
  Map<String, dynamic> doc;
}

abstract class _ClientSubscriptionsMixin implements _DdpClientWrapper {
  Stream<Map<String, dynamic>> sub(String name, List<dynamic> args) async* {
    if (args == null) {
      this._getDdpClient().sub(name, []);
    } else {
      this._getDdpClient().sub(name, [args[0], false]);
    }
    const update = 'update';
    StreamController<UpdateEvent> controller = StreamController(sync: false);
    this._getDdpClient().collectionByName(args[0]).addUpdateListener(
        (String collection, String operation, String id,
            Map<String, dynamic> doc) {
      if (operation == update) {
        controller.add(UpdateEvent()
          ..collection = collection
          ..operation = operation
          ..id = id
          ..doc = doc);
        return controller.stream;
      }
    });
  }
}
