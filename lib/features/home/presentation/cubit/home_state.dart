part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}
class QuranLoading extends HomeState {}
class QuranLoaded extends HomeState {
  final List<SurahModel> surahs;
  QuranLoaded(this.surahs);

  @override
  List<Object?> get props => [surahs];
}
class QuranFailure extends HomeState {
  final String message;
  QuranFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class AyatLoading extends HomeState {}
class AyatLoaded extends HomeState {
  final List ayat;
  AyatLoaded(this.ayat);

  @override
  List<Object?> get props => [ayat];
}
class AyatFailure extends HomeState {
  final String message;
  AyatFailure(this.message);

  @override
  List<Object?> get props => [message];
}
class ThemeChanged extends HomeState {
  final Color backgroundColor;
  final bool isDark;
  const ThemeChanged(this.backgroundColor,this.isDark);

  @override
  List<Object?> get props => [backgroundColor,isDark];
}