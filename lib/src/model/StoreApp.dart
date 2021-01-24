
import 'package:intl/intl.dart';

class StoreApp {

  String steamId;
  String name;
  DateTime releaseDate;
  List<String> developers;
  List<String> publishers;
  String headerImageUrl;

  StoreApp({
    this.steamId,
    this.name,
    this.releaseDate,
    this.developers,
    this.publishers,
    this.headerImageUrl,
  });

  StoreApp.fromJsonData(dynamic jsonData) {

    steamId = jsonData['steam_appid'].toString();
    name = jsonData['name'];
    releaseDate = DateFormat('dd MMM, yyyy', 'en_US').parse(jsonData['release_date']['date']);
    developers = [...jsonData['developers']];
    publishers = [...jsonData['publishers']];
    headerImageUrl = jsonData['header_image'];
  }
}