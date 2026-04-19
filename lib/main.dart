import 'package:flutter/material.dart';
import 'package:kyrgyz_kuhnya/src/app/app.dart';
import 'package:kyrgyz_kuhnya/src/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}
