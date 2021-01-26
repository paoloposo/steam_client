
import 'package:json_annotation/json_annotation.dart';

part 'CurrentlyPlaying.g.dart';

/// Information about the game a user is currently playing.
@JsonSerializable(explicitToJson: true)
class CurrentlyPlaying {

  /// The Steam store ID of the game the user currently plays.
  String appId;

  /// The IP address and port of the game server the user is currently on.
  ///
  /// Is in the format '<IP address>:<port>' if the information is provided or
  /// null otherwise.
  String server;

  /// A String of additional information, if provided, null otherwise.
  String extraInfo;

  CurrentlyPlaying({this.appId, this.server, this.extraInfo});

  factory CurrentlyPlaying.fromJson(Map<String, dynamic> json) => _$CurrentlyPlayingFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentlyPlayingToJson(this);
}