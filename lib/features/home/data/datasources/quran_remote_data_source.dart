import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quran_kareem/features/home/data/models/surah_model.dart';

class QuranLocalDataSource {
  Future<List<SurahModel>> getAllSurahs() async {
    final String response = await rootBundle.loadString('assets/quran.json');
    final data = jsonDecode(response);

    final surahsJson = data['data']['surahs'] as List;
    return surahsJson.map((e) => SurahModel.fromJson(e)).toList();
  }

  Future<List<AyahModel>> getAyatBySurah(int surahNumber) async {
    final allSurahs = await getAllSurahs();
    final surah = allSurahs.firstWhere((s) => s.number == surahNumber);

    return surah.ayahs;
  }
}
