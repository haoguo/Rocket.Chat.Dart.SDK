import 'package:ddp/ddp.dart';
import 'package:rocket_chat_dart/models/models.dart';
import 'package:rocket_chat_dart/realtime/client.dart';
import 'package:test/test.dart';

void main() {
  // deploy a rocket chat server locally
  // create a user named admin with password equals to admin
  // to run this test.
  test('test realtime rocket.chat client', () {
    Client client = Client(
        'test-1',
        Uri(
          scheme: 'http',
          host: 'localhost',
          port: 80,
        ),
        true);
    client.addStatusListener((status) async {
      if (status == ConnectStatus.connected) {
        await client.login(UserCredentials()
          ..name = 'admin'
          ..password = 'admin');
        final channels = await client.getChannelsIn();
        channels.forEach((channel) {
          client.subRoomMessages(channel.id);
        });
        client.roomMessages().listen((data) => print(data.doc));
      }
    });
  });
}
