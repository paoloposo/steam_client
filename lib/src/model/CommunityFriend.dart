
class CommunityFriend {

  String steamId;
  DateTime friendSince;

  CommunityFriend({
    this.steamId,
    this.friendSince,
  });

  CommunityFriend.fromJsonData(dynamic jsonData) {

    steamId = jsonData['steamid'];
    friendSince = DateTime.fromMillisecondsSinceEpoch(jsonData['friend_since']*1000);
  }
}