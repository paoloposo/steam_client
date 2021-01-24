
import 'package:steam_client/map_cache.dart';
import 'package:steam_client/steam_client.dart';

/// A drop-in replacement for [SteamClient] that wraps the client in a simple
/// cache layer.
///
/// Uses the [map_cache] library to provide caching functionality.
///
/// Currently, the following types of resources are cached:
/// - [CommunityProfile]
/// - [CommunityGroup]
class CachedSteamClient extends SteamClient {

  /// Cache for retrieved [CommunityProfile] objects.
  MapCache<String, CommunityProfile> _profilesCache;

  /// Cache for retrieved [CommunityGroup] objects.
  MapCache<String, CommunityGroup> _groupsCache;

  CachedSteamClient({
    String apiKey,
    bool useLegacyApi = false,
  }) : super(
    apiKey: apiKey,
    useLegacyApi: useLegacyApi,
  ) {
   _profilesCache = MapCache((ids) async => await super.getProfiles(ids));
   _groupsCache = MapCache((ids) async {
       var futures = ids.map((id) => super.getGroup(id: id)).toList();
       return Future.wait(futures);
     });
  }

  @override
  Future<List<CommunityProfile>> getProfiles(List<String> profileIds) async {
    return _profilesCache.getMultiple(profileIds);
  }

  @override
  Future<CommunityGroup> getGroup({String name, String id}) async {

    // only one of {name, id} may be set
    assert((name != null) != (id != null));

    if (id != null) {
      return _groupsCache.get(id);
    }
    else {
      var group = _groupsCache.cache.values.singleWhere((element) => element.uniqueName == name, orElse: () => null);
      if (group == null) {
        group = await super.getGroup(name: name);
        _groupsCache.cache[group.steamId] = group;
      }
      return group;
    }
  }
}