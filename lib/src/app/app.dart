import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kyrgyz_kuhnya/src/app/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = GetIt.I<AppRouter>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
