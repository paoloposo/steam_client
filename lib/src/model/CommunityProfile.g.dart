// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommunityProfile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityProfile _$CommunityProfileFromJson(Map<String, dynamic> json) {
  return CommunityProfile(
    steamId: json['steamId'] as String,
    displayName: json['displayName'] as String,
    url: json['url'] as String,
    avatar: json['avatar'] == null
        ? null
        : CommunityAvatar.fromJson(json['avatar'] as Map<String, dynamic>),
    onlineState:
        _$enumDecodeNullable(_$OnlineStateEnumMap, json['onlineState']),
    profilePrivacy:
        _$enumDecodeNullable(_$PrivacySettingEnumMap, json['profilePrivacy']),
    lastLogoff: json['lastLogoff'] == null
        ? null
        : DateTime.parse(json['lastLogoff'] as String),
    allowsPublicComments: json['allowsPublicComments'] as bool,
    realName: json['realName'] as String,
    primaryGroupId: json['primaryGroupId'] as String,
    currentlyPlaying: json['currentlyPlaying'] == null
        ? null
        : CurrentlyPlaying.fromJson(
            json['currentlyPlaying'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommunityProfileToJson(CommunityProfile instance) =>
    <String, dynamic>{
      'steamId': instance.steamId,
      'displayName': instance.displayName,
      'url': instance.url,
      'avatar': instance.avatar?.toJson(),
      'onlineState': _$OnlineStateEnumMap[instance.onlineState],
      'profilePrivacy': _$PrivacySettingEnumMap[instance.profilePrivacy],
      'lastLogoff': instance.lastLogoff?.toIso8601String(),
      'allowsPublicComments': instance.allowsPublicComments,
      'realName': instance.realName,
      'primaryGroupId': instance.primaryGroupId,
      'currentlyPlaying': instance.currentlyPlaying?.toJson(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$OnlineStateEnumMap = {
  OnlineState.offline: 'offline',
  OnlineState.online: 'online',
  OnlineState.busy: 'busy',
  OnlineState.away: 'away',
  OnlineState.snooze: 'snooze',
  OnlineState.lookingToTrade: 'lookingToTrade',
  OnlineState.lookingToPlay: 'lookingToPlay',
};

const _$PrivacySettingEnumMap = {
  PrivacySetting.public: 'public',
  PrivacySetting.private: 'private',
};
