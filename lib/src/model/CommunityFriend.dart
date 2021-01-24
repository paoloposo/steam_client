
/// An entry in the friends list of a Steam profile.
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
}