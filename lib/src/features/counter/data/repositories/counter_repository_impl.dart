import 'package:kyrgyz_kuhnya/src/core/db/app_database.dart';
import 'package:kyrgyz_kuhnya/src/core/storage/prefs_storage.dart';
import 'package:kyrgyz_kuhnya/src/features/counter/domain/repositories/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  CounterRepositoryImpl({
    required AppDatabase database,
    required PrefsStorage prefsStorage,
  })  : _database = database,
        _prefsStorage = prefsStorage;

  final AppDatabase _database;
  final PrefsStorage _prefsStorage;

  @override
  Future<int> getCounter() async {
    final dbValue = await _database.getLatestCounter();
    if (dbValue != null) {
      return dbValue;
    }

    return (await _prefsStorage.getCachedCounter()) ?? 0;
  }

  @override
  Future<int> increment() async {
    final current = await getCounter();
    final updated = current + 1;

    await _database.saveCounterValue(updated);
    await _prefsStorage.setCachedCounter(updated);

    return updated;
  }
}
