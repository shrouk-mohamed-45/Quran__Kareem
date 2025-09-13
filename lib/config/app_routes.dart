import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_kareem/features/get_ayat/presentation/pages/ayat_screen.dart';
import 'package:quran_kareem/features/home/presentation/cubit/home_cubit.dart';
import '../features/home/data/models/surah_model.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../features/splash/pages/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String splashScreen = '/splashScreen';
  static const String homeScreen = '/home_screen';
  static const String ayatScreen = '/ayat_screen';

}


class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    //final args = routeSettings.arguments as Map<String, dynamic>?;
    switch (routeSettings.name) {
    // ───────────────────────── splash ─────────────────────────
    //case Routes.initialRoute:
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

    // ───────────────────────── All-Screens ─────────────────────────
      case Routes.homeScreen:
        return MaterialPageRoute(
            builder: (context) => HomeScreen()
        );

      case Routes.ayatScreen:
        final surah = routeSettings.arguments as SurahModel;
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: context.read<HomeCubit>(),
              child: AyatScreen(surah: surah),
            )
        );

    // ─────────────── default ─────────────────
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("404 - Route Not Found")),
          ),
        );
    }
  }}