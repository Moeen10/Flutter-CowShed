
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Model/COWModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/Cubit/AddSection/addMilkCubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/Cubit/Details/MilkDetailsCubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/Cubit/Details/MilkDetailsState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/Model/MilkDetailsModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/PopUpMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MilkDetails extends StatefulWidget {
  final COW? cow;
  MilkDetails({Key? key , required this.cow}) : super(key: key);

  @override
  State<MilkDetails> createState() => _MilkDetailsState();
}

class _MilkDetailsState extends State<MilkDetails> {

  TextEditingController milkInput = TextEditingController();
  TextEditingController newmilkController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime pickedDate = DateTime.now();

  Future<void> _selectDateNextVaccine(BuildContext context , TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        pickedDate = picked;
      });
      controller.text = picked.toString().split(' ')[0];
    } else {
      controller.text = ''; // Set it to an empty string if nothing is picked
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("সকল তথ্য"),
        elevation: 0,
      ),
      body:

      BlocProvider(
        create: (context) => MilkDetailsCubit(id: widget.cow?.id ?? 0),
        child: BlocConsumer<MilkDetailsCubit, MilkDetailsState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<MilkDetailsCubit>(context);

            if (state is LoadingState){return LoadingIndicator();}

            else if(state is GetDataState){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Color(0xff48C282),
                      height: 60,
                      width: double.infinity,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.cow?.cattleId ?? "Nai",style: TextStyle(fontSize: 18,color: Colors.white),),
                              Text(widget.cow?.origin ?? "Origin Nai",style: TextStyle(fontSize: 18,color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(4),
                          2: FlexColumnWidth(6),
                        },
                        border: TableBorder.all(),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                            ),
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'নং',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'তারিখ',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'লিটার',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          for (int i = 0; i < state.milkProduct.length; i++)
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '${i+1}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '${state.milkProduct[i].date}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '${state.milkProduct[i].milkProduced}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        ElevatedButton(onPressed: (){
                                          PopupInputForBloc(context,milkInput,"Give Input",bloc.update,"number",state.milkProduct[i]);
                                        }, child: Text("Update"))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(

                          onTap: () {
                            AddMilkPrevious(context,dateController,milkInput,widget.cow,bloc.fetchDataFromAPI);

                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 25,
                          child: Icon(Icons.add,color: Colors.white,size: 45),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }
            if (state is UpdatedState) {
              return Container();
            }
            else{
              return Text("ERROR ");
            }
          },
          listener: (context, state) {
            if (state is UpdatedState) {
              PopupMessage( context, "Done","Update Successfully");
            }
          },
        ),
      ),
    );
  }
}



Future PopupInputForBloc(BuildContext context,TextEditingController controller ,String title,Function function,String keyBoardType,MilkProduction milkProduction){
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
            controller: controller,
          keyboardType: keyBoardType=="number"? TextInputType.number : TextInputType.text,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              String value = controller.text;
              controller.clear();
              function(value,milkProduction);
              Navigator.of(ctx).pop();

            },
            child: Text("Submit"),
          ),
        ],
      );
    },
  );
}

Future<void> AddMilkPrevious(BuildContext context, TextEditingController dateController, TextEditingController milkController, COW? cow, Function function) {
  Future<void> postMilkFunction() async {
    print(dateController.text);
    String text = milkController.text;
    int milkProduced = int.parse(text);
    final data = {
      'cow': cow?.id,
      'date': dateController.text,
      'milk_produced': milkProduced,
    };
    String jsonData = jsonEncode(data);
    final url = Uri.parse('${AppBaseURL.BaseUrl}postMilk/');

    try {
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

        // PopupMessage(context, "Done", 'Add MilkYield successfully.');
        Get.showSnackbar(
          GetSnackBar(
            title: "Done",
            icon: const Icon(Icons.done),
            backgroundColor: Color(0xff736b6b),
            duration: const Duration(seconds: 3),
            messageText: Text(
              'Update Done',
              style: TextStyle(color: Colors.yellow), // Set your desired text color here
            ),
          ),
        );

        milkController.clear();
        dateController.clear();
        function(cow?.id ?? 0);
      } else {
        // Handle errors or failure
        print('Failed to create MilkYield object. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        // PopupMessage(context, "Error", 'Error Because of ${response.statusCode}');
        milkController.clear();
        dateController.clear();
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            icon: const Icon(Icons.not_interested),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            messageText: Text(
              'Update Failed',
              style: TextStyle(color: Colors.yellow), // Set your desired text color here
            ),
          ),
        );
      }
    } catch (e) {
      PopupMessage(context, "Error", 'Have Some Issue');
      print(e.toString());
    }
  }

  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text("${cow!.cattleId} এর নতুন রেকর্ড যোগ করুন"),
        content: Container(
          height: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDateField(context, "তারিখ", dateController),
              SizedBox(height: 20,),
              Text("পরিমান ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
              TextField(
                controller: milkController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              print(dateController.text);
              print(milkController.text);
              postMilkFunction();
              Navigator.of(ctx).pop();
            },
            child: Text("Submit"),
          ),
        ],
      );
    },
  );
}


Widget buildDateField(BuildContext context,String Title , TextEditingController controllerName,){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(Title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
      SizedBox(height: 10,),
      Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border:Border.all(color: Color(0xff54A800),width: 2),
            color: Colors.white
        ),

        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [

              SvgPicture.asset(
                "assets/images/calender.svg", // Replace with your SVG asset path
                width: 24, // Adjust the width as needed
                height: 24, // Adjust the height as needed
              ),
              Expanded(
                child: TextField(
                  controller: controllerName,
                  onTap: () =>_selectDateNextVaccine(context,controllerName),
                  decoration:
                  InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

DateTime pickedDate = DateTime.now();

Future<void> _selectDateNextVaccine(BuildContext context , TextEditingController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    // setState(() {
    //   pickedDate = picked;
    // });
    controller.text = picked.toString().split(' ')[0];
  } else {
    controller.text = ''; // Set it to an empty string if nothing is picked
  }
}