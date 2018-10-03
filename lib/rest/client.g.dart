// GENERATED CODE - DO NOT MODIFY BY HAND

part of rest;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelsResponse _$ChannelsResponseFromJson(Map<String, dynamic> json) {
  return ChannelsResponse()
    ..channels = (json['channels'] as List)
        ?.map((e) =>
            e == null ? null : Channel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ChannelsResponseToJson(ChannelsResponse instance) =>
    <String, dynamic>{'channels': instance.channels};
