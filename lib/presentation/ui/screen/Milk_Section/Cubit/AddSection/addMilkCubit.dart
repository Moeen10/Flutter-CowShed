import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Model/COWModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/Cubit/AddSection/addMilkState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class MilkAddPageCubit extends Cubit<AddMilkState> {
  MilkAddPageCubit() : super(DefaultPageState());

  Future<void> postMilkFunction(TextEditingController milkQuantity , String date , COW? cow) async {
    emit(LoadingState());
    if (milkQuantity.text.isEmpty) {
      print('Milk Quantity: ${milkQuantity.text}');

      emit(ErrorState("Enter Valid data"));
    }
    print("object--------------------");
    print(date);
    String text = milkQuantity.text;
    int milk_produced = int.parse(text);
    final data = {
      'cow': cow?.id,
      'date': date,
      'milk_produced':milk_produced ,
    };
    String jsonData = jsonEncode(data);
    final url = Uri.parse('${AppBaseURL.BaseUrl}postMilk/');
    try{
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 201) {
        // The object was successfully created (HTTP status code 201 Created)
        print('MilkYield object created successfully.');
        emit(PostSuccessState());
        emit(DefaultPageState());
      } else {
        // Handle errors or failure
        print('Failed to create MilkYield object. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        emit(ErrorState("Post failed Because of ${response.statusCode} "));
        emit(DefaultPageState());
      }
    }
    catch(e){
      emit(ErrorState("Post failed"));
      print(e.toString());
    }

  }

}