part of rest;

abstract class _ClientUsersMixin implements _ClientWrapper {
  Future<void> login(UserCredentials credentials) {
    Completer<void> completer = Completer();
    http.post('${_getUrl()}/login', headers: {
      'Content-Type': 'application/json',
    }, body: json.encode(<String, String>{
      'user': credentials.name,
      'password': credentials.password,
    })).then((response) {
      final data = json.decode(response.body)['data'];
      this._auth = _AuthInfo(data['userId'], data['authToken']);
      completer.complete(null);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }
}