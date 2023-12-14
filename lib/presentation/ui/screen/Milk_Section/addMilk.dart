import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Model/COWModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/Cubit/AddSection/addMilkCubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/Cubit/AddSection/addMilkState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/milkDetails.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/PopUpMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class AddMilk extends StatelessWidget {
  final COW? cow;
  const AddMilk({Key? key, required this.cow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();

    // Format the date as a string
    String formattedDate = "${now.year}-${now.month}-${now.day}";
    TextEditingController milkQuantity = TextEditingController();
    return  Scaffold(
      backgroundColor: Color(0xffd7e5e8),
      appBar: AppBar(
        centerTitle: true,
        title: Text("দৈনিক দুধ যুক্ত"),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => MilkAddPageCubit(),
        child: BlocConsumer<MilkAddPageCubit, AddMilkState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<MilkAddPageCubit>(context);

            if (state is LoadingState){return LoadingIndicator();}

            else if(state is DefaultPageState){return

              Column(
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
                            Text("গরুর আইডি ${cow?.cattleId}",style: TextStyle(fontSize: 18,color: Colors.white),),
                            Text("${cow?.origin}",style: TextStyle(fontSize: 18,color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 220,
                            width: 320,
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("assets/images/calender.svg"),
                                      SizedBox(width: 50,),
                                      Text('<', style: TextStyle(fontSize: 24,color: Colors.green),),
                                      Text(
                                        ' $formattedDate ',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Text('>', style: TextStyle(fontSize: 24,color: Colors.green),),
                                    ],
                                  ),
                                  Divider(color: Colors.green),
                                  Expanded(
                                    // ------------------------------   Milk Quantity Input ----------------------
                                  child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 45,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.green),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Center(
                                                child: TextField(
                                                  keyboardType: TextInputType.number,
                                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                                  controller: milkQuantity,
                                                  decoration: InputDecoration(
                                                    hintText: "পরিমাণ",
                                                    hintStyle: TextStyle(fontWeight: FontWeight.w300,fontSize: 20),
                                                    contentPadding: EdgeInsets.zero, // Remove default TextField padding
                                                    border: InputBorder.none,
                                                    enabledBorder: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              height: 45,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.green),
                                              ),
                                              child: Center(child: Text("লিটার",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                              )
                                          )
                                        ],
                                      )
                                  )
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(
                            height: 40,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(onPressed: (){
                                  if(milkQuantity.text.isNotEmpty){
                                    bloc.postMilkFunction(milkQuantity,formattedDate,cow);
                                    milkQuantity.clear();
                                  }
                                  else{

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(milliseconds: 800),
                                        content: Text('Please enter a valid milk quantity'),
                                      ),
                                    );
                                  }
                                  }, child: Text("সংরক্ষণ",style: TextStyle(fontSize: 25),)),
                                SizedBox(width: 20,),
                                ElevatedButton(onPressed: (){Get.to(MilkDetails(cow:cow));}, child: Text("রেকর্ড দেখুন",style: TextStyle(fontSize: 25),)),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            else if(state is PostSuccessState){
              return Container();
            }
            // else if(state is ErrorState){
            //   return ErrorMessage(context, "Error",state.eMessage);
            // }
            else{
              return Text("ERROR UnKnown");
            }
          },
          listener: (context, state) {
            // final bloc = BlocProvider.of<MilkDetailsCubit>(context);
            if(state is ErrorState){
              PopupMessage(context,"Error",state.eMessage);
            }
            else if( state is PostSuccessState){
              PopupMessage(context,"Done","Add Milk Yeild Done");
            }
          },
        ),
      ),


    );
  }
}


