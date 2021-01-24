
class MapCache<S, T> {

  Map<S, T> cache = {};
  Future<List<T>> Function(List<S> keys) loader;

  MapCache(this.loader);

  Future<T> get(S key, {bool forceRefresh = false}) async {

    if (!cache.containsKey(key) || forceRefresh) {
      await _load([key]);
    }

    return cache[key];
  }

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

  void _load(List<S> keys) async {

    var data = await loader(keys);
    for (var i=0; i<keys.length; i++) {
      cache[keys[i]] = data[i];
    }
  }

  void evict(S key) {

    cache.remove(key);
  }
}