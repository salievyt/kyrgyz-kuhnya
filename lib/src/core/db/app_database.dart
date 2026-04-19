import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class CounterEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get value => integer()();

  DateTimeColumn get updatedAt => dateTime()();
}

@DriftDatabase(tables: [CounterEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int?> getLatestCounter() async {
    final query = select(counterEntries)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)])
      ..limit(1);

    final latest = await query.getSingleOrNull();
    return latest?.value;
  }

  Future<void> saveCounterValue(int value) async {
    await into(counterEntries).insert(
      CounterEntriesCompanion.insert(
        value: value,
        updatedAt: DateTime.now(),
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'kyrgyz_kuhnya.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
