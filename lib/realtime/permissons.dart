part of realtime;

abstract class _ClientPermissionsMixin implements _DdpClientWrapper {
  Future<List<Permission>> getPermissions() {
    Completer<List<Permission>> completer = Completer();
    // TODO
    return completer.future;
  }

  Future<void> getUserRoles() {
    Completer<void> completer = Completer();
    // TODO;
    return completer.future;
  }
}