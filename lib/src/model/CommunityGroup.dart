
import 'package:xml/xml.dart';

import 'CommunityAvatar.dart';

/// A group in the Steam community.
class CommunityGroup {

  /// Steam ID of the group.
  String steamId;

  /// Current display name of the group.
  ///
  /// The display name of a group can be changed and should not be used to
  /// uniquely identify a group.
  String displayName;

  /// Unique name of the group.
  ///
  /// This is the name that is part of the group's URL when referencing a group
  /// by its name.
  String uniqueName;

  /// Headline text as displayed on the group page.
  String headline;

  /// Summary as displayed on the group page.
  String summary;

  /// The group's avatar.
  CommunityAvatar avatar;

  /// List of Steam IDs of the profiles that are members of this group.
  List<String> memberIds;

  /// Number of members currently in chat.
  int membersInChat;

  /// Number of members currently in-game.
  int membersInGame;

  /// Number of members currently online.
  int membersOnline;

  CommunityGroup({
    this.steamId,
    this.displayName,
    this.uniqueName,
    this.headline,
    this.summary,
    this.avatar,
    this.memberIds,
    this.membersInChat,
    this.membersInGame,
    this.membersOnline,
  });

  /// Instantiate a [CommunityGroup] using the data returned by the legacy Steam
  /// API.
  CommunityGroup.fromXmlString(String xmlString) {

    var data = XmlDocument.parse(xmlString);

    var root = data.getElement('memberList');
    var details = root.getElement('groupDetails');

    steamId = root.getElement('groupID64').text;
    displayName = details.getElement('groupName').text;
    uniqueName = details.getElement('groupURL').text;
    headline = details.getElement('headline').text;
    summary = details.getElement('summary').text;
    avatar = CommunityAvatar(
      smallUrl: details.getElement('avatarIcon').text,
      mediumUrl: details.getElement('avatarMedium').text,
      fullUrl: details.getElement('avatarFull').text,
    );
    membersInChat = int.parse(details.getElement('membersInChat').text);
    membersInGame = int.parse(details.getElement('membersInGame').text);
    membersOnline = int.parse(details.getElement('membersOnline').text);
    memberIds = root.getElement('members').findElements('steamID64').map((e) => e.text).toList();
  }
}