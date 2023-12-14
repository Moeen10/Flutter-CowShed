import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/DeviceWiseSensor/Cubit/States.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/DeviceWiseSensor/Model/parameterListModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeviceWiseSensorCubit extends Cubit<DeviceWiseSensorCubitState> {
  DeviceWiseSensorCubit() : super(LoadingState()){
    sendPostRequest();
  }

  void changeMode(String value) async{

    String valueAsche = value;
    emit(LoadingState());
    print("ASFASFSA    +++++++++++   $value");
    if(value=="0"){
      value="1";
      print(value);
    }
    else if(value=="1"){
      value="0";
      print(value);
    }


    try {
      var response = await http.post(
        Uri.parse(AppBaseURL.ParameterStatusSet),
        headers: {
          "Authorization": "Bearer ${GetToken.token}",
        },
        body: {
          "parameter[]": "1-${value}",
        },
      );

      if (response.statusCode == 200) {
        sendPostRequest();
      } else {
        print("POST request failed with status: ${response.statusCode}");
        ErrorMessageState("Cannot Change");
        emit(SuccessState(valueAsche));
      }
    } catch (e) {
      print("Error during POST request: $e");
      ErrorMessageState("Cannot Change");
      emit(SuccessState(valueAsche));
    }

  }

  void sendPostRequest() async {

    try {
      var response = await http.get(
        Uri.parse(AppBaseURL.ParameterList),
        headers: {
          "Authorization": "Bearer ${GetToken.token}",
        },
      );

      if (response.statusCode == 200) {
        print("POST request successful!");
        ParameterListModel parameterListModel =  ParameterListModel.fromJson(json.decode(response.body));
        print("EIKHANE ASE MAN  : ${parameterListModel.data![0].value}");
        String? value = parameterListModel.data![0].value;
        emit(SuccessState(value!));
      } else {
        print("POST request failed with status: ${response.statusCode}");
        // ErrorMessageState("Value Set Failed");
      }
    } catch (e) {
      print("Error during POST request: $e");
      // ErrorMessageState("Request Failed");
    }
  }

}
