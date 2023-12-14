
abstract class ManualSetState{}

class LoadingState extends ManualSetState{}

class SetState extends ManualSetState {}
class SuccessState extends ManualSetState{}
class ErrorMessageState extends ManualSetState{
  final String errorMessage ;
  ErrorMessageState(this.errorMessage);
}
