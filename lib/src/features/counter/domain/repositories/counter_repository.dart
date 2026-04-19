abstract interface class CounterRepository {
  Future<int> getCounter();

  Future<int> increment();
}
