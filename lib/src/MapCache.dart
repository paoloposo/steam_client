
/// Callback to load items that are not in the cache.
///
/// Gets a list of [keys] to load and returns a [Future] list of corresponding
/// items. Items in the returned list must be in the same order as [keys].
typedef Loader<S, T> = Future<List<T>> Function(List<S> keys);

/// A simple cache that stores data in a [Map] in memory.
///
/// MapCache supports loading items that are not yet in the cache.
/// Multiple items can be loaded simultaneously to more efficiently use the
/// underlying structure.
class MapCache<S, T> {

  /// The cache [Map].
  Map<S, T> cache = {};

  /// Callback to load items that are not in the cache.
  final Loader<S, T> loader;

  MapCache(this.loader);

  /// Get a single item by its [key].
  ///
  /// If the item is not yet in the cache, it will be loaded using the [loader]
  /// and subsequently added to the cache.
  /// If the item is already in the cache, setting [forceRefresh] to true will
  /// re-load the item and replace its entry in the cache.
  ///
  /// Returns a [Future] that resolves to the item once loading is finished.
  Future<T> get(S key, {bool forceRefresh = false}) async {

    if (!cache.containsKey(key) || forceRefresh) {
      await _load([key]);
    }

    return cache[key];
  }

  /// Get multiple items by their [keys].
  ///
  /// If the items are not yet in the cache, the will be loaded simultaneously
  /// using the [loader].
  /// If the items are already in the cache, setting [forceRefresh] to true will
  /// force re-loading of all specified items and replace their entries in the
  /// cache.
  ///
  /// Returns a [Future] that resolves to a list of items once loading is
  /// finished.
  Future<List<T>> getMultiple(List<S> keys, {bool forceRefresh = false}) async {

    var items = <S, T>{};
    var missingKeys = <S>[];

    keys.forEach((key) {
      if (cache.containsKey(key)) {
        items[key] = cache[key];
      }
      else {
        missingKeys.add(key);
      }
    });

    if (missingKeys.isNotEmpty) {
      await _load(missingKeys);
      missingKeys.forEach((key) => items[key] = cache[key]);
    }

    return keys.map((key) => items[key]).toList();
  }

  /// Use the [loader] to load the items specified by their [keys].
  void _load(List<S> keys) async {

    var data = await loader(keys);
    for (var i=0; i<keys.length; i++) {
      cache[keys[i]] = data[i];
    }
  }
}