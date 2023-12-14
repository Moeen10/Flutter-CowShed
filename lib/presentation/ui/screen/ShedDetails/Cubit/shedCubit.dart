import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/Cubit/shedState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/Model/LatestDataModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/shedDetails.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ShedCubit extends Cubit<ShedState> {
  ShedCubit() : super(LoadingState()) {
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    http.Response response = await http.get(
      Uri.parse(AppBaseURL.LatestSensorValue),
      headers: {"Authorization": "Bearer ${GetToken.token}"},
    );
    if (response.statusCode == 200) {
      // Parse the JSON response
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      LatestSensorModel latestSensorModel = LatestSensorModel.fromJson(jsonResponse);
      emit(SuccessState(latestSensorModel));
    } else {
      // Print an error message if the request was not successful
      print("Failed to fetch data. Status code: ${response.statusCode}");
    }
  }
}