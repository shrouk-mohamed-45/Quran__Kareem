import 'package:dartz/dartz.dart';
import 'package:quran_kareem/core/error/failures.dart';
import 'package:quran_kareem/features/home/data/models/surah_model.dart';
import '../datasources/quran_remote_data_source.dart';

class QuranRepositoryImpl {
  final QuranLocalDataSource localDataSource;

  QuranRepositoryImpl({required this.localDataSource});

  Future<Either<Failure, List<SurahModel>>> getAllSure() async {
      try {
        final surah = await localDataSource.getAllSurahs();
        return Right(surah);
      } catch (error) {
        return Left(LocalFailure(message: error.toString()));
      }
  }

  Future<Either<Failure, List<AyahModel>>> getAyat(int surahNumber) async {
    try {
      final ayahs = await localDataSource.getAyatBySurah(surahNumber);
      return Right(ayahs);
    } catch (error) {
      return Left(LocalFailure(message: error.toString()));
    }
  }
}