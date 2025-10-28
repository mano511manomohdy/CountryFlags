import 'package:bloc/bloc.dart';
import 'package:country_flag/features/presentation/Controller/cubit/country_flag_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'country_flag_state.dart';

class CountryFlagCubit extends Cubit<CountryFlagState> {
  CountryFlagCubit() : super(CountryFlagInitial());

  Future<void> get_Flags() async {
    Dio dio = Dio();
    emit(CountryFlagLoading());
    try {
      var res = await dio.get(
        "https://restcountries.com/v3.1/all?fields=name,flags,region,capital,population",
      );
      var data = (res.data as List)
          .map((e) => CountryModel.fromJson(e))
          .toList();
      emit(CountryFlagSuccess(data: data));
    } catch (e) {
      if (e is TypeError) {
        print(e.stackTrace);
      }
      emit(CountryFlagFailure());
      throw e;
    }
  }
}
