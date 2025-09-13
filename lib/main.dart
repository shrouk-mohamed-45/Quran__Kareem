import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_kareem/core/dependency_injection/service_locator.dart' as di;
import 'app.dart';
import 'bloc_observer.dart';
import 'dart:developer' as developer;
import 'config/app_routes.dart';

void main() async {
  Bloc.observer = AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  // Lock the app to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Initialize dependency injection
  await di.init();

  runApp(const MyApp(
    initialRoute: Routes.splashScreen,
  ));
}