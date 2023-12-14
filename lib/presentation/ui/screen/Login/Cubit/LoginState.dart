abstract class LoginState{}


class LoginSuccess extends LoginState {}
class InitialState extends LoginState {}
class LoadingState extends LoginState {}
class SuccessState extends LoginState {}

class ErrorState extends LoginState {
  final String errorMessage ;
  ErrorState(this.errorMessage);
}
