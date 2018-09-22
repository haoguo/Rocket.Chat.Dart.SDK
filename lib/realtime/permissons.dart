part of realtime;

abstract class _ClientPermissionsMixin implements _DdpClientWrapper {
  Future<List<Permission>> getPermissions() {
    Completer<List<Permission>> completer = Completer();
    this._getDdpClient().call('permissions/get', []).then((call) {
      final permissions = <Permission>[];
      (call.reply as List).forEach((perm) => permissions.add(Permission()
        ..roles = (perm['roles'] as List).map((role) => role).toList()
        ..id = '${perm['_id']}'));
      completer.complete(permissions);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<void> getUserRoles() {
    Completer<void> completer = Completer();
    this
        ._getDdpClient()
        .call('getUserRoles', [])
        .then((call) => completer.complete(null))
        .then((error) => completer.completeError(null));
    return completer.future;
  }
}
