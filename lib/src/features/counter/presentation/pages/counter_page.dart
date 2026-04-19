import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kyrgyz_kuhnya/src/features/counter/presentation/bloc/counter_bloc.dart';

@RoutePage()
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<CounterBloc>()..add(CounterStarted()),
      child: const _CounterView(),
    );
  }
}

class _CounterView extends StatelessWidget {
  const _CounterView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clean Architecture starter')),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Counter value from Drift + SharedPrefs:'),
                const SizedBox(height: 8),
                Text(
                  '${state.value}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterBloc>().add(CounterIncrementPressed());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
