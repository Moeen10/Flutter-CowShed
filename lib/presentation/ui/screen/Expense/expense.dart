
import 'dart:convert';

import 'package:cow_profile_and_shed_management/presentation/ui/screen/Expense/Cubit/ExpenseCubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Expense/Cubit/ExpenseStates.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Expense/Model/InventoryModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/BuildTextAndDateField.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/SizeDrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utility/base_url.dart';






class Expense extends StatelessWidget {
   Expense({Key? key}) : super(key: key);

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final TextEditingController quantity = TextEditingController();
   final TextEditingController food = TextEditingController();
   final TextEditingController foodID = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("ইনভেন্টরি আউট করুন"),
        ),
        drawer: SideDrawer(),
        body:BlocProvider(
          create: (context) => ExpensePageCubit(),
          child: BlocConsumer<ExpensePageCubit, ExpanseState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<ExpensePageCubit>(context);
              if (state is LoadingState) {
                return LoadingIndicator();
              }
              else if (state is GetDataState){

                return Container(
                  color: Color(0xffdbe3e7),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(height: 10,),
                                  DropdownField(controller: food,title: "খাদ্যের ধরণ",items: state.forFoodDropdown),
                                  SizedBox(height: 10,),

                                  //Quantity

                                  buildTextField("পরিমাণ", quantity, "পরিমাণ দিন Kgতে", "number" ),
                                  SizedBox(height: 10,),

                                  //Submit Button
                                  SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child:
                                      ElevatedButton(onPressed: (){
                                        if (_formKey.currentState?.validate() ?? false) {
                                          double? quantityValue = double.tryParse(quantity.text);
                                          bloc.postExpenseRecord(food.text, quantityValue!);
                                          food.clear();
                                          quantity.clear();
                                        }
                                        else{
                                          print("|||||||||||||||||||");
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text("Error"),
                                                content: Text("Give all Input"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context); // Close the dialog
                                                    },
                                                    child: Text("OK"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                        // showData();
                                      },
                                          child: Text("SUBMIT")
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              else{
                return Text("ABAR ReStart Diye Dekhen (3");
              }
            },
            listener: (context, state) {
              if(state is SuccessState){
                Get.showSnackbar(
                  GetSnackBar(
                    title: "Success",
                    icon: const Icon(Icons.done),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 3),
                    messageText: Text(
                      'Post Successfully',
                      style: TextStyle(color: Colors.yellow), // Set your desired text color here
                    ),
                  ),
                );
              }
              else if(state is ErrorState){
                Get.showSnackbar(
                  GetSnackBar(
                    title: "Failed",
                    icon: const Icon(Icons.not_interested),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                    messageText: Text(
                      'Post Failed',
                      style: TextStyle(color: Colors.yellow), // Set your desired text color here
                    ),
                  ),
                );
              }
            },
          ),
        ),
    );
  }




}

class DropdownField extends StatelessWidget {
  final String title;
  final List<String> items;
  final TextEditingController controller;

  DropdownField({required this.title, required this.items, required this.controller});

  @override
  Widget build(BuildContext context) {
    String? selectedValue = controller.text.isEmpty ? null : controller.text; // Set initially to null if controller is empty
    print("AKSFMASf");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
        SizedBox(height: 10,),
        DropdownButtonFormField<String?>(
          value: selectedValue, // Set initially to null
          items: [
            DropdownMenuItem<String?>(
              value: null, // Value for null
              child: Text("Select an option"),
            ),
            ...items.map((item) {
              return DropdownMenuItem<String?>(
                value: item,
                child: Text("${utf8.decode(item.runes.toList())}"),
              );
            }),
          ],
          onChanged: (value) {
            // Update the selected value in the controller
            if (value != null) {
              controller.text = value;
            } else {
              controller.text = ""; // Handle null value by clearing the text
            }
          },
          decoration: InputDecoration(
            // labelText: 'Select $title',
          ),
        ),
      ],
    );
  }
}

