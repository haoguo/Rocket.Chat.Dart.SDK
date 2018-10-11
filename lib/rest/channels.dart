part of rest;

@JsonSerializable()
class ChannelsResponse {
  ChannelsResponse();

  @JsonKey(name: 'channels')
  List<Channel> channels;

  factory ChannelsResponse.fromJson(Map<String, dynamic> json) =>
      _$ChannelsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelsResponseToJson(this);
}

abstract class _ClientChannelsMixin implements _ClientWrapper {
  Future<List<Channel>> getPublicChannels() {
    Completer<List<Channel>> completer = Completer();
    http.get('${_getUrl()}/channels.list', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
    }).then((response) {
      _hackResponseHeader(response);
      final channelsResponse =
          ChannelsResponse.fromJson(json.decode(response.body));
      completer.complete(channelsResponse.channels);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }

  Future<List<Channel>> getPublicChannelsJoined() {
    Completer<List<Channel>> completer = Completer();
    http.get('${_getUrl()}/channels.list.joined', headers: {
      'X-User-Id': _auth._id,
      'X-Auth-Token': _auth._token,
    }).then((response) {
      _hackResponseHeader(response);
      final channelsResponse =
          ChannelsResponse.fromJson(json.decode(response.body));
      completer.complete(channelsResponse.channels);
    }).catchError((error) => completer.completeError(error));
    return completer.future;
  }
}
