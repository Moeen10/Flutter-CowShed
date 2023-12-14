import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/Cubit/Details/MilkDetailsState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/Model/MilkDetailsModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class MilkDetailsCubit extends Cubit<MilkDetailsState> {
  final int id;
  MilkDetailsCubit({required this.id}) : super(LoadingState()) {
    fetchDataFromAPI(id);

  }

  Future<void> fetchDataFromAPI(int id) async {
    print("KKKKKKKKKKKKKKKK");
    final url = Uri.parse('${AppBaseURL.BaseUrl}milk-post/$id/');
    try{
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // final json = jsonDecode(response.body);
        final json = jsonDecode(response.body) as List;

        // Parse the JSON data into a list of MilkProduction objects.
        final milkProductions = json.map((production) => MilkProduction.fromJson(production)).toList();
        emit(GetDataState(milkProductions));
      } else {
        print("ERROR FROM ELSE");
      }
    }
    catch(e){
      print("ERROR FROM Catch");
      throw Exception('Failed to load data');
    }

  }

  Future<void> update(String value,MilkProduction milkProduction) async {
    emit(LoadingState());
    print("Moeen---------------");
    print(milkProduction.id);
    final url = Uri.parse('${AppBaseURL.BaseUrl}updateMilk/');
    final data = {
      "cow": milkProduction.cow,
      "date":milkProduction.date,
      "milk_produced":value,
      "id":milkProduction.id
    };

    String jsonData = jsonEncode(data);





    try {
      print("Moeen---------------");
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );
      final Map<String, dynamic> responseMap = json.decode(response.body);
      print(responseMap['message'].toString());


      if (response.statusCode == 200) {
        emit(UpdatedState());
        fetchDataFromAPI(milkProduction?.cow ?? 0);
      }else {
        print("ERROR FROM ELSE");
        print(response.statusCode);
        emit(ErrorState("Error Cz ${response.statusCode}"));
      }
    } catch (e) {
      print("ERROR FROM Catch");
      emit(ErrorState("Error Unknown "));
      throw Exception('Failed to load data');
    }


    fetchDataFromAPI(milkProduction?.cow ?? 0);
  }

  Future<void> Add()async{
    print("JKO");
  }

}

