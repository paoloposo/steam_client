
/// An avatar for an entity in the Steam community.
///
/// This class stores URLs of three differently sized avatar images.
class CommunityAvatar {

  /// URL of the small (32x32) avatar.
  String smallUrl;

  /// URL of the medium-sized (64x64) avatar.
  String mediumUrl;

  /// URL of the full-sized avatar.
  String fullUrl;

  CommunityAvatar({
    this.smallUrl,
    this.mediumUrl,
    this.fullUrl
  });
}