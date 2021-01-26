// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StoreApp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreApp _$StoreAppFromJson(Map<String, dynamic> json) {
  return StoreApp(
    appId: json['appId'] as String,
    name: json['name'] as String,
    releaseDate: json['releaseDate'] == null
        ? null
        : DateTime.parse(json['releaseDate'] as String),
    developers: (json['developers'] as List)?.map((e) => e as String)?.toList(),
    publishers: (json['publishers'] as List)?.map((e) => e as String)?.toList(),
    headerImageUrl: json['headerImageUrl'] as String,
  );
}

Map<String, dynamic> _$StoreAppToJson(StoreApp instance) => <String, dynamic>{
      'appId': instance.appId,
      'name': instance.name,
      'releaseDate': instance.releaseDate?.toIso8601String(),
      'developers': instance.developers,
      'publishers': instance.publishers,
      'headerImageUrl': instance.headerImageUrl,
    };
