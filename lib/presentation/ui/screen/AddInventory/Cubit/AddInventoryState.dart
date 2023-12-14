import 'package:cow_profile_and_shed_management/presentation/ui/screen/Expense/Model/InventoryModel.dart';

abstract class AddInventoryState{}

class LoadingState extends AddInventoryState{}
class DefaultState extends AddInventoryState{}
class GetDataState extends AddInventoryState {
  final List<InventoryModel> allFood;
  final List<String> forFoodDropdown = [];

  GetDataState(this.allFood) {
    populateForFoodDropdown();
  }

  void populateForFoodDropdown() {
    for (int i = 0; i < allFood.length; i++) {
      String? name = allFood[i].name;
      if (name != null) {
        forFoodDropdown.add(name);
      }
    }
  }
}
class ErrorState extends AddInventoryState{
  final String errorMessage;
  ErrorState(this.errorMessage);
}
class SuccessState extends AddInventoryState{}