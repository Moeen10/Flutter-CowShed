

import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddInventory/Cubit/AddInventoryState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Expense/Model/InventoryModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';


class AddInventoryCubit extends Cubit<AddInventoryState> {
  AddInventoryCubit() : super(LoadingState()) {
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    emit(LoadingState());
    final url = Uri.parse('${AppBaseURL.BaseUrl}inventory_list/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List;

        // Parse the JSON data into a list of MilkProduction objects.
        final data = json.map((production) => InventoryModel.fromJson(production)).toList();
        emit(GetDataState(data));
      } else {
        emit(ErrorState("Error Type : ${response.statusCode}"));
        print("ERROR FROM ELSE");
      }
    } catch (e) {
      emit(ErrorState("${e.toString()}"));
      print("ERROR FROM Catch");
      throw Exception('Failed to load data');
    }
  }

  Future<void> postAddInventoryRecord(String controllerValue , double quantity , double amountValue ) async{
    try{
      emit(LoadingState());
      final response = await http.post(
        Uri.parse('${AppBaseURL.BaseUrl}inventory_add/'),
        body: {
          'crop_type': utf8.decode(controllerValue.runes.toList()),  // Use the correct variable name
          'quantity': quantity.toString(),
          'amount': amountValue.toString(),
        },
      );

      if (response.statusCode == 201) {
        // Data was successfully sent to the server
        print('Data sent successfully.');
        print('66666666666666666666666666');
        postSuccess();
      } else {
        // Handle the error
        emit(ErrorState("${response.body}"));
        print('Failed to send data. Error: ${response.body}');
        print('999999999999999');
      }
    }
    catch(e){
      emit(ErrorState("Failed For Some Issue"));
    }


  }
  void postSuccess(){
    emit(SuccessState());
    fetchDataFromAPI();
  }
}
