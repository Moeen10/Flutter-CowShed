abstract class AddMilkState{}

class DefaultPageState extends AddMilkState{}
class LoadingState extends AddMilkState{}
class PostSuccessState extends AddMilkState{}
class ErrorState extends AddMilkState{
  final String eMessage;
  ErrorState(this.eMessage);
}