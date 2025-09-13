import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/app_routes.dart';
import 'core/dependency_injection/service_locator.dart';
import 'features/home/presentation/cubit/home_cubit.dart';


// Global navigator key that can be accessed from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  final String? initialRoute;
  const MyApp({super.key, this.initialRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: false,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
            create: (_) => sl<HomeCubit>()..fetchAllSurahs(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: widget.initialRoute,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}