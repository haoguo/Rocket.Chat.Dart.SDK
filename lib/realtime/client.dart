library realtime;

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:ddp/ddp.dart' as ddp;
import 'package:rocket_chat_dart/models/models.dart';

part 'channels.dart';
part 'emoji.dart';
part 'events.dart';
part 'messages.dart';
part 'permissons.dart';
part 'subscriptions.dart';
part 'users.dart';
part 'livechat.dart';

abstract class _DdpClientWrapper {
  ddp.DdpClient _getDdpClient();
}

typedef void _StatusListener(ddp.ConnectStatus status);

class Client extends Object
    with
        _ClientChannelsMixin,
        _ClientEmojiMixin,
        _ClientEventsMixin,
        _ClientPermissionsMixin,
        _ClientMessagesMixin,
        _ClientUsersMixin,
        _ClientSubscriptionsMixin,
        _ClientLiveChatMixin
    implements _DdpClientWrapper {
  Client(String name, Uri uri, bool debug) {
    String wsUrl = 'ws';
    int port = 80;
    if (uri.scheme == 'https') {
      wsUrl = 'wss';
      port = 443;
    }
    if (uri.port != null) {
      port = uri.port;
    }
    wsUrl = '$wsUrl://${uri.host}:$port/websocket';
    this._ddp = ddp.DdpClient(name, wsUrl, uri.toString());
    if (debug) {
      this._ddp.setSocketLogActive(true);
    } else {
      this._ddp.setSocketLogActive(false);
    }
    this._ddp.connect();
  }

  ddp.DdpClient _ddp;

  @override
  ddp.DdpClient _getDdpClient() => this._ddp;

  void reconnect() {
    this._ddp.reconnect();
  }

  void connectionAway() => this._ddp.call('UserPresence:away', []);

  void connectionOnline() => this._ddp.call('UserPresence:online', []);

  void close() => this._ddp.close();

  void addStatusListener(_StatusListener listener) =>
      this._getDdpClient().addStatusListener(listener);
}

final Random _random = Random(DateTime.now().millisecondsSinceEpoch);

String _randomId() => '${_random.nextDouble()}';
