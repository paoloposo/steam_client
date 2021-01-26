// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommunityGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityGroup _$CommunityGroupFromJson(Map<String, dynamic> json) {
  return CommunityGroup(
    steamId: json['steamId'] as String,
    displayName: json['displayName'] as String,
    uniqueName: json['uniqueName'] as String,
    headline: json['headline'] as String,
    summary: json['summary'] as String,
    avatar: json['avatar'] == null
        ? null
        : CommunityAvatar.fromJson(json['avatar'] as Map<String, dynamic>),
    memberIds: (json['memberIds'] as List)?.map((e) => e as String)?.toList(),
    membersInChat: json['membersInChat'] as int,
    membersInGame: json['membersInGame'] as int,
    membersOnline: json['membersOnline'] as int,
  );
}

Map<String, dynamic> _$CommunityGroupToJson(CommunityGroup instance) =>
    <String, dynamic>{
      'steamId': instance.steamId,
      'displayName': instance.displayName,
      'uniqueName': instance.uniqueName,
      'headline': instance.headline,
      'summary': instance.summary,
      'avatar': instance.avatar?.toJson(),
      'memberIds': instance.memberIds,
      'membersInChat': instance.membersInChat,
      'membersInGame': instance.membersInGame,
      'membersOnline': instance.membersOnline,
    };
