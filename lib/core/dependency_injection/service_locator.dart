import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quran_kareem/features/home/data/datasources/quran_remote_data_source.dart';
import 'package:quran_kareem/features/home/data/repositories/quran_repository_impl.dart';
import 'package:quran_kareem/features/home/presentation/cubit/home_cubit.dart';

import '../network/network_error_provider.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;
Future<void> init() async {

  // Core - Dio
  sl.registerLazySingleton(() => Dio());

// Data sources
  sl.registerLazySingleton<QuranLocalDataSource>(() => QuranLocalDataSource());

  // Repositories
  sl.registerLazySingleton<QuranRepositoryImpl>(() => QuranRepositoryImpl(localDataSource: sl()),);

  // Cubits
  sl.registerFactory(() => HomeCubit(repository: sl()));


  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

// Register network error provider
  sl.registerLazySingleton(() => NetworkErrorProvider(networkInfo: sl()));

  // Internet checker
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
