
import 'package:xml/xml.dart';

import 'CommunityAvatar.dart';

class CommunityGroup {

  String steamId;
  String displayName;
  String uniqueName;
  String headline;
  String summary;
  CommunityAvatar avatar;
  List<String> memberIds;
  int membersInChat;
  int membersInGame;
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