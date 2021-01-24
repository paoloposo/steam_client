
import 'CommunityAvatar.dart';
import 'CurrentlyPlaying.dart';

enum PrivacySetting {
  public,
  private,
}

enum OnlineState {
  offline,
  online,
  busy,
  away,
  snooze,
  lookingToTrade,
  lookingToPlay,
}

class CommunityProfile {

  String steamId;
  String displayName;
  String url;
  CommunityAvatar avatar;
  OnlineState onlineState;
  PrivacySetting profilePrivacy;
  DateTime lastLogoff;
  bool allowsPublicComments;
  String realName;
  String primaryGroupId;
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

  CommunityProfile.fromJsonData(dynamic jsonData) {

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
      gameId: jsonData['gameid'],
      server: jsonData['gameserverip'],
      extraInfo: jsonData['gameextrainfo'],
    ) : null;
  }

  CommunityProfile.fromXmlString(String xmlString) {

    throw UnsupportedError('not yet supported');
  }
}