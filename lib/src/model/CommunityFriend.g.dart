// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommunityFriend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityFriend _$CommunityFriendFromJson(Map<String, dynamic> json) {
  return CommunityFriend(
    steamId: json['steamId'] as String,
    friendSince: json['friendSince'] == null
        ? null
        : DateTime.parse(json['friendSince'] as String),
  );
}

Map<String, dynamic> _$CommunityFriendToJson(CommunityFriend instance) =>
    <String, dynamic>{
      'steamId': instance.steamId,
      'friendSince': instance.friendSince?.toIso8601String(),
    };
