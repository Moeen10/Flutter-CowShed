import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Model/COWModel.dart';
// For Cow Add page
abstract class CowListState{}

class LoadingState extends CowListState{}

class GetAllDataState extends CowListState{
   // final List<dynamic>allcow;
   final List<COW> cows;
   GetAllDataState(this.cows);
}

class ErrorMessageState extends CowListState{
   final String errorMessage ;
   ErrorMessageState(this.errorMessage);
}





// For Cow Update Page


abstract class CowUpdateState{}

class  CowUpdateLoadingState extends CowUpdateState{}

class  CowUpdateGetAllDataState extends CowUpdateState{
   // final List<dynamic>allcow;
   final List<COW> cows;
   CowUpdateGetAllDataState(this.cows);
}

class CowUpdateErrorMessageState extends CowUpdateState{
   final String errorMessage ;
   CowUpdateErrorMessageState(this.errorMessage);
}