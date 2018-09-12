library realtime;

import 'dart:async';

import 'package:ddp/ddp.dart';
import 'package:rocket.chat.dart/models/models.dart';

part 'channels.dart';
part 'emoji.dart';
part 'events.dart';
part 'permissons.dart';

abstract class _DdpClientWrapper {
  DdpClient _getDdpClient();
}

class Client extends Object
    with _ClientChannelsMixin, _ClientEmojiMixin, _ClientEventsMixin
    implements _DdpClientWrapper {
  DdpClient ddp;

  @override
  DdpClient _getDdpClient() => this.ddp;
}
