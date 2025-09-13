import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_kareem/core/utils/app_colors.dart';
import '../../data/models/surah_model.dart';
import '../../data/repositories/quran_repository_impl.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final QuranRepositoryImpl repository;
  Color backgroundColor = AppColors.secondaryColor;
  HomeCubit({required this.repository}) : super(HomeInitial());

  Future<void> fetchAllSurahs() async {
    emit(QuranLoading());
    final result = await repository.getAllSure();
    result.fold(
      (failure) => emit(QuranFailure(failure.message ?? 'Unknown error')),
      (sure) => emit(QuranLoaded(sure)),
    );
  }

  Future<void> fetchAyat(int surahNumber)async{
    emit(AyatLoading());
    final result = await repository.getAyat(surahNumber);
    result.fold(
          (failure) => emit(AyatFailure(failure.message ?? 'Unknown error')),
          (ayahs) => emit(AyatLoaded(ayahs)),
    );
  }

  // void changeTheme() {
  //   if (backgroundColor == AppColors.secondaryColor) {
  //     backgroundColor = Colors.white;
  //     emit(ThemeChanged(backgroundColor, false));
  //   } else {
  //     backgroundColor = AppColors.secondaryColor;
  //     emit(ThemeChanged(backgroundColor, true));
  //   }
  // }
}
