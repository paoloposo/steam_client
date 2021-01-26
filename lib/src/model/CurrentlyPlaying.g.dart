// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CurrentlyPlaying.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentlyPlaying _$CurrentlyPlayingFromJson(Map<String, dynamic> json) {
  return CurrentlyPlaying(
    appId: json['appId'] as String,
    server: json['server'] as String,
    extraInfo: json['extraInfo'] as String,
  );
}

Map<String, dynamic> _$CurrentlyPlayingToJson(CurrentlyPlaying instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'server': instance.server,
      'extraInfo': instance.extraInfo,
    };
