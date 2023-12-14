import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/Model/MilkDetailsModel.dart';

abstract class MilkDetailsState{}

class LoadingState extends MilkDetailsState {}
class GetDataState extends MilkDetailsState {
  final List<MilkProduction> milkProduct;
  GetDataState(this.milkProduct);
}
class ErrorState extends MilkDetailsState {
  final String eMessage;
  ErrorState(this.eMessage);
}
class UpdatedState extends MilkDetailsState {}
