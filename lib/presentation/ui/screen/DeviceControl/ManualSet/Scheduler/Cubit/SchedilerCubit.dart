import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/Scheduler/Cubit/SchedulerState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/Scheduler/Model/SchedulerModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
class SchedulerCubit extends Cubit<SchedulerState> {
  SchedulerCubit() : super(LoadingState()){
    sendPostRequest();
  }

  String giveValue(String inputTime){
    if (inputTime == null || inputTime.length != 4) {
      print('Invalid time format. Please try again.');
      return '';
    }

    int hours = int.parse(inputTime.substring(0, 2));
    int minutes = int.parse(inputTime.substring(2));

    String outputTime;

    if (hours == 0 && minutes == 0) {
      outputTime = '12:00 AM'; // Handle midnight separately
    } else if (hours == 12 && minutes == 0) {
      outputTime = '12:00 PM'; // Handle noon separately
    } else {
      String amPm = 'AM';
      if (hours >= 12) {
        amPm = 'PM';
        hours -= 12; // Convert to 12-hour format
      }

      outputTime = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $amPm';
    }

    print('$inputTime is $outputTime');
    return outputTime;
  }

  void sendPostRequest() async {
    String url = AppBaseURL.ParameterList;

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer ${GetToken.token}"},
      );

      if (response.statusCode == 200) {
        print("OKKK");
        Map<String, dynamic> responseBody = json.decode(response.body);
        List<dynamic> dataList = responseBody["data"];

        if (dataList.length >= 3) {
          String valueAtIndex1 = dataList[1]["value"];
          String valueAtIndex2 = dataList[2]["value"];
          valueAtIndex1 = giveValue(valueAtIndex1);
          valueAtIndex2 = giveValue(valueAtIndex2);
          print(giveValue(valueAtIndex1));
          print(giveValue(valueAtIndex2));
          emit(GetDataState(valueAtIndex1,valueAtIndex2));
          // emit(GetDataState(start_time, end_time));
        } else {
          print("Invalid data structure");
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

}
