import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/Cubit/ManualSetCubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/Cubit/ManualSetState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/BuildTextAndDateField.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class IndividualFielSetValueManually extends StatelessWidget {
  final int Id;
  final String title;

  IndividualFielSetValueManually({Key? key, required this.Id, required this.title}) : super(key: key);



  TextEditingController valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Set Value $Id")),
      appBar: AppBar(title: Text("মান নির্ধারণ করুন")),
      body:

      BlocProvider(
        create: (context) => ManualValueCubit(),
        child: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<ManualValueCubit>(context);

            return BlocConsumer<ManualValueCubit, ManualSetState>(
                bloc: cubit,
                builder: (context, state){
                  if(state is LoadingState){
                    return LoadingIndicator();
                  }
                  if(state is SetState){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: buildTextField(title, valueController, "মান সেট করুন", "number"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: (){
                                cubit.sendPostRequest(Id, valueController.text);
                                valueController.clear();
                              }, child: Text("সেট করুন")),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                  else {
                    return Container();
                  }
                },
                listener: (context, state){
                  if(state is SuccessState){
                    Get.snackbar(
                      backgroundColor: Color(0xff008000),
                      colorText: Color(0xffffffff),
                      "Done",
                      "Set Value Sucsessfully",
                    );
                  }
                  else if(state is ErrorMessageState){
                    Get.snackbar(
                      backgroundColor: Color(0xff008000),
                      colorText: Color(0xffffffff),
                      "Error",
                      "${state.errorMessage}"
                    );
                  }
                },
            );
          },
        ),
      ),




    );
  }
}

