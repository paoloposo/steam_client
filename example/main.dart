import 'package:steam_client/steam_client.dart';

void main() async {
  // Put your API key here.
  // API keys can be obtained at https://steamcommunity.com/dev/apikey.
  const apiKey = '36A76AF048AA5F0532B49BE4C2C8BE42';

  // instantiate a client object with an api key
  var steamClient = SteamClient(apiKey: apiKey);

  // Get a profile by id and print the display name and avatar URL.
  var profileId = '76561197984767093';
  var profile = await steamClient.getProfile(profileId);
  print('Display name of profile $profileId is \'${profile.displayName}\'.');
  print('URL of full-sized avatar of ${profile.displayName}\'s profile is ${profile.avatar.fullUrl}');
  print('');

  // Get a group by name and print its headline and number of online members.
  var group = await steamClient.getGroup(name: 'steamuniverse');
  print('Headline of group \'${group.displayName}\' is:\n${group.headline}');
  print('Currently online: ${group.membersOnline}');
  print('');

  // Get a group by id and print its display name.
  var groupId = '103582791466847704';
  var group2 = await steamClient.getGroup(id: groupId);
  print('Display name of group ${group2.uniqueName} is \'${group2.displayName}\'');
  print('');

  // Instantiate a client without an api key.
  // Legacy mode must be enabled.
  SteamClient(useLegacyApi: true);
  // Clients in legacy mode can be used in the same way as clients with api key.
  // However, some operations (e.g. batch profile retrieval) are less efficient
  // as they use one request per resource.

  // Instantiate a client which caches resources in memory.
  var cachedSteamClient = CachedSteamClient(apiKey: apiKey);
  // Check the documentation of the CachedSteamClient class to see which types
  // of resources are cached.

  // Cached clients are a drop-in replacement for normal clients, so they can be
  // used in exactly the same manner.
  var profile2 = await cachedSteamClient.getProfile(profileId);
  print('Profile of ${profile2.displayName} is now in the cache.');

  // Subsequent requests will load the resource from the cache.
  // This also works for batch retrieval of profiles.
  profile2 = (await cachedSteamClient.getProfiles([profileId])).first;
  print('You won\'t notice, but profile of ${profile2.displayName} was fetched from cache.');
}
