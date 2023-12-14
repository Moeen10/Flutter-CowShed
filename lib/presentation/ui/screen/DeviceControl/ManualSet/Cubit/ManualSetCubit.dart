import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/Cubit/ManualSetState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/setManualCondition.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManualValueCubit extends Cubit<ManualSetState> {
  ManualValueCubit() : super(SetState()) ;

  void sendPostRequest(int index,String value) async {
    print("$index " + " $value");
    try {
      var response = await http.post(
        Uri.parse(AppBaseURL.ParameterStatusSet),
        headers: {
          "Authorization": "Bearer ${GetToken.token}",
        },
        body: {
          "parameter[]": "${index}-${value}",
        },
      );

      if (response.statusCode == 200) {
        print("POST request successful!");
        emit(SuccessState());
        emit(SetState());
        // Get.to(SetManualCondition());
        Get.to(SetManualCondition());
      } else {
        print("POST request failed with status: ${response.statusCode}");
        ErrorMessageState("Value Set Failed");
      }
    } catch (e) {
      print("Error during POST request: $e");
      ErrorMessageState("Request Failed");
    }
  }

}
