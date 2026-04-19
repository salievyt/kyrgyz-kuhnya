import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyrgyz_kuhnya/src/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:kyrgyz_kuhnya/src/features/counter/domain/usecases/increment_counter_usecase.dart';

sealed class CounterEvent {}

final class CounterStarted extends CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

class CounterState {
  const CounterState({
    this.value = 0,
    this.isLoading = false,
  });

  final int value;
  final bool isLoading;

  CounterState copyWith({
    int? value,
    bool? isLoading,
  }) {
    return CounterState(
      value: value ?? this.value,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc({
    required GetCounterUseCase getCounterUseCase,
    required IncrementCounterUseCase incrementCounterUseCase,
  })  : _getCounterUseCase = getCounterUseCase,
        _incrementCounterUseCase = incrementCounterUseCase,
        super(const CounterState()) {
    on<CounterStarted>(_onStarted);
    on<CounterIncrementPressed>(_onIncrementPressed);
  }

  final GetCounterUseCase _getCounterUseCase;
  final IncrementCounterUseCase _incrementCounterUseCase;

  Future<void> _onStarted(
    CounterStarted event,
    Emitter<CounterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final value = await _getCounterUseCase();
    emit(state.copyWith(value: value, isLoading: false));
  }

  Future<void> _onIncrementPressed(
    CounterIncrementPressed event,
    Emitter<CounterState> emit,
  ) async {
    final updated = await _incrementCounterUseCase();
    emit(state.copyWith(value: updated));
  }
}
