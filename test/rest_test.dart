import 'package:rocket_chat_dart/models/models.dart';
import 'package:rocket_chat_dart/rest/client.dart';
import 'package:test/test.dart';

void main() {
  // deploy a rocket chat server locally
  // create a user named admin with password equals to admin
  // to run this test.
  test('test rest rocket.chat client', () async {
    Client client = Client(
        Uri(
          scheme: 'http',
          host: 'localhost',
          port: 80,
        ),
        true);
    await client.login(UserCredentials()
      ..name = 'admin'
      ..password = 'admin');
    (await client.getPublicChannels())
        .forEach((channel) => print(channel.toJson()));
  });
}
