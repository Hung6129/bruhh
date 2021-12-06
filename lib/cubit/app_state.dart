import 'package:bruhh/model/data_model.dart';
import 'package:equatable/equatable.dart';

abstract class CubitStates extends Equatable {}

class InitialStates extends CubitStates {
  @override
  List<Object> get props => [];
}

class WellcomeState extends CubitStates {
  @override
  List<Object> get props => [];
}

class LoadingState extends CubitStates {
  @override
  List<Object> get props => [];
}

class LoadedState extends CubitStates {
  LoadedState(this.places);
  final List<DataModel> places;
  @override
  List<Object> get props => [places];
}
