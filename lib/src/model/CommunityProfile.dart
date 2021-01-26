
import 'package:json_annotation/json_annotation.dart';

import 'CommunityAvatar.dart';
import 'CurrentlyPlaying.dart';

part 'CommunityProfile.g.dart';

/// Privacy setting of a Steam profile.
///
/// If the privacy is [private], certain information about the profile cannot be
/// retrieved.
enum PrivacySetting {
  public,
  private,
}

/// Online state of the profile as adjustable in the friends list.
enum OnlineState {
  offline,
  online,
  busy,
  away,
  snooze,
  lookingToTrade,
  lookingToPlay,
}

/// A Steam profile.
@JsonSerializable(explicitToJson: true)
class CommunityProfile {

  /// The Steam ID of the profile.
  String steamId;

  /// The current display name of the profile.
  ///
  /// Users can change the display name of their Steam profile through the Steam
  /// website.
  String displayName;

  /// The URL of the profile.
  String url;

  /// The avatar of the profile.
  CommunityAvatar avatar;

  /// The current online state of the profile.
  OnlineState onlineState;

  /// The privacy setting of the profile.
  ///
  /// If set to [PrivacySetting.private], certain information about the profile
  /// cannot be retrieved.
  PrivacySetting profilePrivacy;

  /// The date when the user last logged out of their profile.
  DateTime lastLogoff;

  /// Whether the profile allows public comments.
  bool allowsPublicComments;

  /// The real name of the user owing the profile, if specified.
  String realName;

  /// The Steam ID of the profile's primary group.
  String primaryGroupId;

  /// Information about the game that is currently played by the user owing the
  /// profile.
  ///
  /// If no game is currently being played, this field will be null.
  CurrentlyPlaying currentlyPlaying;

  CommunityProfile({
    this.steamId,
    this.displayName,
    this.url,
    this.avatar,
    this.onlineState,
    this.profilePrivacy,
    this.lastLogoff,
    this.allowsPublicComments,
    this.realName,
    this.primaryGroupId,
    this.currentlyPlaying,
  });

  /// Instantiate a [CommunityProfile] using the data returned by the Steam Web
  /// API.
  CommunityProfile.fromSteamJson(dynamic jsonData) {

    steamId = jsonData['steamid'];
    displayName = jsonData['personaname'];
    url = jsonData['profileurl'];
    avatar = CommunityAvatar(
      smallUrl: jsonData['avatar'],
      mediumUrl: jsonData['avatarmedium'],
      fullUrl: jsonData['avatarfull'],
    );
    onlineState = OnlineState.values.asMap()[jsonData['personastate']];
    profilePrivacy = {
      1: PrivacySetting.private,
      3: PrivacySetting.public,
    }[jsonData['communityvisibilitystate']];
    lastLogoff = jsonData['lastlogoff'] != null ? DateTime.fromMillisecondsSinceEpoch(jsonData['lastlogoff']) : null;
    allowsPublicComments = jsonData['commentpermission'] == 1;
    realName = jsonData['realname'];
    primaryGroupId = jsonData['primaryclanid'];
    currentlyPlaying = jsonData['gameid'] != null ? CurrentlyPlaying(
      appId: jsonData['gameid'],
      server: jsonData['gameserverip'],
      extraInfo: jsonData['gameextrainfo'],
    ) : null;
  }

  /// Instantiate a [CommunityProfile] using the data returned by the legacy
  /// Steam API.
  CommunityProfile.fromSteamXml(String xmlString) {

    throw UnsupportedError('not yet supported');
  }

  factory CommunityProfile.fromJson(Map<String, dynamic> json) => _$CommunityProfileFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityProfileToJson(this);
}