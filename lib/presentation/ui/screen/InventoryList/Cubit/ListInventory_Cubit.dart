import 'package:cow_profile_and_shed_management/presentation/ui/screen/InventoryList/Cubit/ListInventory_State.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListInventoryCubit extends Cubit<ListInventoryState> {
  ListInventoryCubit() : super(LoadingState()) {
    fetchDataFromAPI();
  }
Future<void> fetchDataFromAPI() async {
  final url = Uri.parse('${AppBaseURL.BaseUrl}allAddInventory');
  try{
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      emit(GetAllData(data));
    } else {
      emit(ErrorState("Error Type : ${response.statusCode}"));
      print("ERROR FROM ELSE");

    }
  }
  catch(e){
    emit(ErrorState("${e.toString()}"));
    print("ERROR FROM Catch");
    throw Exception('Failed to load data');
  }

}

}
