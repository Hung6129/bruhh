import 'package:bruhh/cubit/app_state.dart';
import 'package:bruhh/service/service_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialStates()) {
    emit(WellcomeState());
  }
  final DataService data;
  late final places;
  Future<void> getData() async {
    try {
      emit(LoadingState());
      places = await data.getInfo();
      emit(LoadedState(places));
    } catch (e) {}
  }
}
