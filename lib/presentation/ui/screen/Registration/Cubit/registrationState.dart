abstract class RegistrationState{}


class LoginSuccess extends RegistrationState {}
class InitialState extends RegistrationState {}
class LoadingState extends RegistrationState {}
class SuccessState extends RegistrationState {}

class ErrorState extends RegistrationState {
  final String errorMessage ;
  ErrorState(this.errorMessage);
}
