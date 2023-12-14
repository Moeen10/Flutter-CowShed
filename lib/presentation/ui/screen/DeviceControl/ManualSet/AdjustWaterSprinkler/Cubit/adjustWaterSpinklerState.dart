import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/AdjustFan/Model/DeviceStatusModel.dart';

abstract class AdjustWaterSpinklerState{}

class LoadingState extends AdjustWaterSpinklerState{}

class PeripheralGroupStatusDoneState extends AdjustWaterSpinklerState{}
class PeripheralDeviceStatusDataState extends AdjustWaterSpinklerState{
  final DeviceStatusModel modelData;
  final bool available;
  // PeripheralDeviceStatusDataState(this.modelData,this.available);
  PeripheralDeviceStatusDataState(this.modelData,this.available);
}

class ErrorMessageState extends AdjustWaterSpinklerState{
  final String errorMessage ;
  ErrorMessageState(this.errorMessage);
}
