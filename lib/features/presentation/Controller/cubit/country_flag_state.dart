part of 'country_flag_cubit.dart';

@immutable
sealed class CountryFlagState {}

final class CountryFlagInitial extends CountryFlagState {}

final class CountryFlagLoading extends CountryFlagState {}

final class CountryFlagSuccess extends CountryFlagState {
  final List<CountryModel> data;

  CountryFlagSuccess({required this.data});
}

final class CountryFlagFailure extends CountryFlagState {}
