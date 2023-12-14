import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Cubit/Cow_ProFile/CowProfile_State.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Model/COWModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CowProfileCubit extends Cubit<CowListState> {
  CowProfileCubit() : super(LoadingState()) {
    fetchDataFromAPI();
  }
  Future<void> fetchDataFromAPI() async {

    final url = Uri.parse('${AppBaseURL.BaseUrl}reqiestForAllCowProfile/');
    try{
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("*************** COW Model Received Data *******************");
         // print(data[0]);
        List<COW> cows = data.map((json) => COW.fromJson(json)).toList();
        print("*************** COW Model Takes In List<Cow> *******************");
        print("*************** All Done From COW Models *******************");

        emit(GetAllDataState(cows));
      } else {
        emit(ErrorMessageState("Error Type : ${response.statusCode}"));
        print("ERROR FROM ELSE");
      }
    }
    catch(e){
      emit(ErrorMessageState("${e.toString()}"));
      print("ERROR FROM Catch");
      throw Exception('Failed to load data');
    }

  }

}



