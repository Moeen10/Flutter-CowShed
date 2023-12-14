import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/deseaseModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/medicineModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/vaccineModel.dart';

abstract class AddCowStates{}

class DeseaseListforChipsChoiceEmpty extends AddCowStates{}


class DeseaseAndVaccineAndMedicineList extends AddCowStates{
  final List<DESEASE> desease;
  final List<VACCINE> vaccine;
  final List<MEDICINE> medicine;
  DeseaseAndVaccineAndMedicineList(this.desease,this.vaccine,this.medicine);
}



class Loading extends AddCowStates{}

class ErrorState extends AddCowStates {
  final String errorMessage ;
  ErrorState(this.errorMessage);
}


