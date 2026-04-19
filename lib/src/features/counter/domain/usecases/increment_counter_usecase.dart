import 'package:kyrgyz_kuhnya/src/features/counter/domain/repositories/counter_repository.dart';

class IncrementCounterUseCase {
  IncrementCounterUseCase(this._repository);

  final CounterRepository _repository;

  Future<int> call() {
    return _repository.increment();
  }
}
