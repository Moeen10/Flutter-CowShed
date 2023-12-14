import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/AdjustFan/Cubit/adjustFanState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/AdjustFan/Model/DeviceStatusModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdjustFanCubit extends Cubit<AdjustFanState> {
  AdjustFanCubit() : super(LoadingState()) {
    fetchDataFromAPI();
  }
  Future<void> fetchDataWithInterval() async {
      await Future.delayed(Duration(seconds: 5));
  }


  Future<void> fetchDataFromAPI() async {

    final url1 = Uri.parse('${AppBaseURL.PeripheralGroupStatus}');
    final url = Uri.parse('${AppBaseURL.DevicePeripheralLastStatus}');

    // Group Status Get
    try{
      final response = await http.get(
        url1,
        headers: {"Authorization": "Bearer ${GetToken.token}"},
      );

      if (response.statusCode == 200) {
        print("ASSCHE");
        print(response.body);
      } else {
        emit(ErrorMessageState("Error Type : ${response.statusCode}"));
        print("ERROR FROM ELSE");
      }
    }
    catch(e){
      emit(ErrorMessageState("${"Peripheral Group Status Failed"}"));
      print("ERROR FROM Catch Peripharal Group Status");
      throw Exception('Failed to load data');
    }
    //Set Here 5 Secounds Time intertval For MQTT response max time

    await fetchDataWithInterval();

    // Device Status Get

    try{
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer ${GetToken.token}"},
      );

      if (response.statusCode == 200) {
        print("Paisi Device Data");
        final deviceStatusModel = DeviceStatusModel.fromJson(json.decode(response.body));
        List<bool> available = await f(deviceStatusModel);
        print(available);
        // emit(PeripheralDeviceStatusDataState(deviceStatusModel,available as List<bool>));
        emit(PeripheralDeviceStatusDataState(deviceStatusModel,available));
      } else {
        emit(ErrorMessageState("Error Type : ${response.statusCode}"));
        print("ERROR FROM ELSE");
      }
    }
    catch(e){
      emit(ErrorMessageState("${"Device Data Get Request Failed"}"));
      print("ERROR FROM Catch Peripharal Device Latest Data");
      throw Exception('Failed to load data');
    }

  }

  Future<List<bool>> f(DeviceStatusModel value) async {
    List<bool> available = List<bool>.filled(6, false);
    for (int i = 0; i < value.data!.length; i++) {
      if (value.data![i].peripheralType == "fan" ) {
        int index =  int.parse(value.data![i].peripheralIndex.toString());
        print("Index = $index");
        if(value.data![i].status == "0"){
          available[index-1]=false;
        }
        else{
          available[index-1]=true;
        }
      }
    }
    return available;
  }

}



