import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/AdjustFan/Model/DeviceStatusModel.dart';

abstract class AdjustFanState{}

class LoadingState extends AdjustFanState{}

class PeripheralGroupStatusDoneState extends AdjustFanState{}
class PeripheralDeviceStatusDataState extends AdjustFanState{
  final DeviceStatusModel modelData;
  final List<bool> available;
  // PeripheralDeviceStatusDataState(this.modelData,this.available);
  PeripheralDeviceStatusDataState(this.modelData,this.available);
}

class ErrorMessageState extends AdjustFanState{
  final String errorMessage ;
  ErrorMessageState(this.errorMessage);
}
