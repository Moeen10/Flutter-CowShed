import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/Model/LatestDataModel.dart';

abstract class ShedState{}


class InitialState extends ShedState {}
class LoadingState extends ShedState {}
class SuccessState extends ShedState {
  final LatestSensorModel latestSensorModel;
  SuccessState(this.latestSensorModel);
}

class ErrorState extends ShedState {
  final String errorMessage ;
  ErrorState(this.errorMessage);
}
