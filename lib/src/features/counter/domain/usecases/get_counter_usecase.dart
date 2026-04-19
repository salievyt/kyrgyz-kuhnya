import 'package:kyrgyz_kuhnya/src/features/counter/domain/repositories/counter_repository.dart';

class GetCounterUseCase {
  GetCounterUseCase(this._repository);

  final CounterRepository _repository;

  Future<int> call() {
    return _repository.getCounter();
  }
}
