
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiver/iterables.dart' as quiver;

import 'model/CommunityFriend.dart';
import 'model/CommunityGroup.dart';
import 'model/CommunityProfile.dart';
import 'model/StoreApp.dart';

/// A client for the Steam API that provides easy access to community and store
/// resources.
///
/// For access to the Steam Web API (which replaces parts of the legacy Steam
/// API), an API key is needed. API keys can be registered at
/// https://steamcommunity.com/dev/apikey, which requires a Steam account.
class SteamClient {

  /// API key for the Steam Web API.
  ///
  /// This field is required in order to use the Steam Web API, however some
  /// resources can still be retrieved using the legacy Steam API.
  final String apiKey;

  /// Indicates whether resources will be retrieved using the legacy Steam API.
  ///
  /// If this is set to true, an [apiKey] is not required.
  final bool useLegacyApi;

  SteamClient({
    this.apiKey,
    this.useLegacyApi = false,
  }){
    assert((apiKey!=null) || useLegacyApi, 'apiKey must be specified unless useLegacyApi is true');
  }

  /// Get a list of Steam profiles matching [profileIds].
  Future<List<CommunityProfile>> getProfiles(List<String> profileIds) async {

    if (!useLegacyApi) {
      var chunks = quiver.partition(profileIds, 100);
      var profiles = <CommunityProfile>[];
      await Future.forEach(chunks, (chunk) async {
        var requestUrl = 'https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=$apiKey&steamids=${chunk.join(',')}';
        var response = await http.get(requestUrl);
        dynamic jsonData = jsonDecode(response.body);
        profiles.addAll(jsonData['response']['players'].map<CommunityProfile>((profileData) => CommunityProfile.fromJsonData(profileData)));
      });
      return profiles;
    }
    else {
      var futures = profileIds.map((profileId) async {
        var requestUrl = 'https://steamcommunity.com/profiles/$profileIds/?xml=1';
        var response = await http.get(requestUrl);
        return CommunityProfile.fromXmlString(response.body);
      });
      return Future.wait(futures);
    }
  }

  /// Get information about a single Steam profile.
  ///
  /// Uses [getProfiles] internally.
  Future<CommunityProfile> getProfile(String profileId) async {

    return (await getProfiles([profileId])).first;
  }

  /// Get the list of friends of a profile.
  Future<List<CommunityFriend>> getFriends(String profileId) async {

    var requestUrl = 'http://api.steampowered.com/ISteamUser/GetFriendList/v0001/?key=$apiKey&steamid=$profileId&relationship=friend';
    var response = await http.get(requestUrl);
    dynamic jsonData = jsonDecode(response.body);

    return jsonData['friendslist']['friends'].map<CommunityFriend>((friendData) => CommunityFriend.fromJsonData(friendData)).toList();
  }

  /// Get information about a Steam group.
  Future<CommunityGroup> getGroup({String name, String id}) async {

    // only one of {name, id} may be set
    assert((name != null) != (id != null));

    String requestUrl;
    if (name != null) {
      requestUrl = 'https://steamcommunity.com/groups/$name/memberslistxml/?xml=1';
    }
    else {
      requestUrl = 'https://steamcommunity.com/gid/$id/memberslistxml/?xml=1';
    }

    var response = await http.get(requestUrl);

    return CommunityGroup.fromXmlString(response.body);
  }

  /// Get information about an app in the Steam store.
  Future<StoreApp> getApp(String id) async {
    var requestUrl = 'https://store.steampowered.com/api/appdetails?hl=en&appids=$id';
    var response = await http.get(requestUrl);
    dynamic jsonData = jsonDecode(response.body);

    return StoreApp.fromJsonData(jsonData[id]['data']);
  }
}