import 'package:shared_preferences/shared_preferences.dart';

class PrefsStorage {
  PrefsStorage(this._prefs);

  final SharedPreferencesAsync _prefs;

  static const _counterKey = 'counter_cached_value';

  static Future<PrefsStorage> create() async {
    return PrefsStorage(SharedPreferencesAsync());
  }

  Future<int?> getCachedCounter() {
    return _prefs.getInt(_counterKey);
  }

  Future<void> setCachedCounter(int value) {
    return _prefs.setInt(_counterKey, value);
  }
}
