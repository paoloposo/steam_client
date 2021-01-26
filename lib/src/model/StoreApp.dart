
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'StoreApp.g.dart';

/// A game or app in the Steam store.
@JsonSerializable()
class StoreApp {

  /// The id of the game or app as listed in the Steam store.
  String appId;

  /// The name of the game or app.
  String name;

  /// The date the game or app was released.
  DateTime releaseDate;

  /// A list of developers of the game or app..
  List<String> developers;

  /// A list of publishers of the game or app.
  List<String> publishers;

  /// URL of the header image of the game or app as displayed on the store page
  /// of the game or app.
  String headerImageUrl;

  StoreApp({
    this.appId,
    this.name,
    this.releaseDate,
    this.developers,
    this.publishers,
    this.headerImageUrl,
  });

  /// Instantiate a [StoreApp] using the data returned by the Steam API.
  StoreApp.fromSteamJson(dynamic jsonData) {

    appId = jsonData['steam_appid'].toString();
    name = jsonData['name'];
    releaseDate = DateFormat('dd MMM, yyyy', 'en_US').parse(jsonData['release_date']['date']);
    developers = [...jsonData['developers']];
    publishers = [...jsonData['publishers']];
    headerImageUrl = jsonData['header_image'];
  }

  factory StoreApp.fromJson(Map<String, dynamic> json) => _$StoreAppFromJson(json);

  Map<String, dynamic> toJson() => _$StoreAppToJson(this);
}