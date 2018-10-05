library rest;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:rocket_chat_dart/models/models.dart';

part 'channels.dart';
part 'client.g.dart';
part 'rooms.dart';
part 'users.dart';

class _AuthInfo {
  _AuthInfo(this._id, this._token);

  final String _id;
  final String _token;
}

abstract class _ClientWrapper {
  String _getUrl();

  _AuthInfo _auth;
}

class Client extends Object
    with _ClientUsersMixin, _ClientChannelsMixin, _ClientRoomsMixin
    implements _ClientWrapper {
  final String protocol;
  final String host;
  final int port;
  final String version;

  final bool debug;

  @override
  _AuthInfo _auth;

  Client(Uri uri, this.debug)
      : this.protocol = uri.scheme,
        this.host = uri.host,
        this.port = uri.port,
        this.version = 'v1';

  @override
  String _getUrl() => '$protocol://$host:$port/api/$version';
}
