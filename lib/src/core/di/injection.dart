import 'package:get_it/get_it.dart';
import 'package:kyrgyz_kuhnya/src/app/router/app_router.dart';
import 'package:kyrgyz_kuhnya/src/core/db/app_database.dart';
import 'package:kyrgyz_kuhnya/src/core/storage/prefs_storage.dart';
import 'package:kyrgyz_kuhnya/src/features/counter/data/repositories/counter_repository_impl.dart';
import 'package:kyrgyz_kuhnya/src/features/counter/domain/repositories/counter_repository.dart';
import 'package:kyrgyz_kuhnya/src/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:kyrgyz_kuhnya/src/features/counter/domain/usecases/increment_counter_usecase.dart';
import 'package:kyrgyz_kuhnya/src/features/counter/presentation/bloc/counter_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton<AppRouter>(AppRouter.new);

  final prefsStorage = await PrefsStorage.create();
  sl.registerSingleton<PrefsStorage>(prefsStorage);

  sl.registerLazySingleton<AppDatabase>(AppDatabase.new);

  sl.registerLazySingleton<CounterRepository>(
    () => CounterRepositoryImpl(
      database: sl<AppDatabase>(),
      prefsStorage: sl<PrefsStorage>(),
    ),
  );

  sl.registerLazySingleton<GetCounterUseCase>(
    () => GetCounterUseCase(sl<CounterRepository>()),
  );
  sl.registerLazySingleton<IncrementCounterUseCase>(
    () => IncrementCounterUseCase(sl<CounterRepository>()),
  );

  sl.registerFactory<CounterBloc>(
    () => CounterBloc(
      getCounterUseCase: sl<GetCounterUseCase>(),
      incrementCounterUseCase: sl<IncrementCounterUseCase>(),
    ),
  );
}
