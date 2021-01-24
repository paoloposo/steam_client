
import 'package:steam_client/map_cache.dart';
import 'package:steam_client/steam_client.dart';

class CachedSteamClient extends SteamClient {

  MapCache<String, CommunityProfile> profilesCache;
  MapCache<String, CommunityGroup> groupsCache;

  CachedSteamClient({
    String apiKey,
    bool useLegacyApi = false,
  }) : super(
    apiKey: apiKey,
    useLegacyApi: useLegacyApi,
  ) {
   profilesCache = MapCache((ids) async => await super.getProfiles(ids));
   groupsCache = MapCache((ids) async {
       var futures = ids.map((id) => super.getGroup(id: id)).toList();
       return Future.wait(futures);
     });
  }

  @override
  Future<List<CommunityProfile>> getProfiles(List<String> profileIds) async {
    return profilesCache.getMultiple(profileIds);
  }

  @override
  Future<CommunityGroup> getGroup({String name, String id}) async {

    // only one of {name, id} may be set
    assert((name != null) != (id != null));

    if (id != null) {
      return groupsCache.get(id);
    }
    else {
      var group = groupsCache.cache.values.singleWhere((element) => element.uniqueName == name, orElse: () => null);
      if (group == null) {
        group = await super.getGroup(name: name);
        groupsCache.cache[group.steamId] = group;
      }
      return group;
    }
  }
}