part of realtime;

class _ddpLoginRequest {
  _ddpUser user;
  _ddpPassword password;

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'password': password,
    };
  }
}

class _ddpTokenLoginRequest {
  String token;

  Map<String, dynamic> toJson() {
    return {
      'resume': token,
    };
  }
}

class _ddpUser {
  String email;
  String username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (email != null && email.trim() != '') {
      map['email'] = email.trim();
    }
    if (username != null && username.trim() != '') {
      map['username'] = username.trim();
    }
    return map;
  }
}

class _ddpPassword {
  String digest;
  String algorithm;

  Map<String, dynamic> toJson() {
    return {
      'digest': digest,
      'algorithm': algorithm,
    };
  }
}

abstract class _ClientUsersMixin implements _DdpClientWrapper {
  Future<User> login(UserCredentials credentials) {
    dynamic request;
    if (credentials.token != null && credentials != '') {
      request = _ddpTokenLoginRequest()..token = credentials.token;
    } else {
      final digest = sha256.convert(utf8.encode(credentials.password));
      request = _ddpLoginRequest()
        ..user = (_ddpUser()
          ..email = credentials.email
          ..username = credentials.name)
        ..password = (_ddpPassword()
          ..digest = digest.toString()
          ..algorithm = 'sha-256');
    }
    Completer<User> completer = Completer();
    this
        ._getDdpClient()
        .call('login', [request])
        .then((call) => completer.complete(User()
          ..id = '${call.reply['id']}'
          ..token = '${call.reply['token']}'
          ..tokenExpires = call.reply['tokenExpires']['\$date']))
        .catchError((error) => completer.completeError(error));
    return completer.future;
  }
}
