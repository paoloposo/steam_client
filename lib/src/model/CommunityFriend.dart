
import 'package:json_annotation/json_annotation.dart';

part 'CommunityFriend.g.dart';

/// An entry in the friends list of a Steam profile.
@JsonSerializable(explicitToJson: true)
class CommunityFriend {

  /// Steam ID of the friend's profile.
  String steamId;

  /// Date when the profile was added to the friends list.
  DateTime friendSince;

  CommunityFriend({
    this.steamId,
    this.friendSince,
  });

  /// Instantiate a [CommunityFriend] using the data returned by the Steam Web
  /// API.
  CommunityFriend.fromJsonData(dynamic jsonData) {

    steamId = jsonData['steamid'];
    friendSince = DateTime.fromMillisecondsSinceEpoch(jsonData['friend_since']*1000);
  }

  factory CommunityFriend.fromJson(Map<String, dynamic> json) => _$CommunityFriendFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityFriendToJson(this);
}