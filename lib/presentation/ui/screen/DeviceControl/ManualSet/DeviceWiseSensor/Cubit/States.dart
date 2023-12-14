
abstract class DeviceWiseSensorCubitState{}

class LoadingState extends DeviceWiseSensorCubitState{}

class SetState extends DeviceWiseSensorCubitState {}
class SuccessState extends DeviceWiseSensorCubitState{
  final String value;
  SuccessState(this.value);
}
class ErrorMessageState extends DeviceWiseSensorCubitState{
  final String errorMessage ;
  ErrorMessageState(this.errorMessage);
}
