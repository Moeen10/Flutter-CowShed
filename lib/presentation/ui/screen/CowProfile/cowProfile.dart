import 'dart:convert';

import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/addCow.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Cubit/Cow_ProFile/CowProfile_Cubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Cubit/Cow_ProFile/CowProfile_State.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Model/COWModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/addMilk.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/cowDetails.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/SizeDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CowProfile extends StatelessWidget {
  const CowProfile({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xffE7E7E7),
        appBar: AppBar(
          centerTitle: true,
          title: Text("গরুর প্রোফাইল"),
        ),
        drawer: SideDrawer(),
        body: BlocProvider(
          create: (context) => CowProfileCubit(),
          child: BlocConsumer<CowProfileCubit, CowListState>(
            builder: (context, state) {
               if (state is LoadingState) {
                return LoadingIndicator();
              }
               else if(state is GetAllDataState){
                 return
                 Column(
                   children: [

                     Expanded(
                       child: ListView.builder(
                         itemCount: state.cows.length,
                         itemBuilder: (context, index) {
                           COW cow = state.cows[index];
                           return Padding(
                             padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 0.0),
                             child: Card(
                               child: Padding(
                                 padding: const EdgeInsets.all(15.0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 40,
                                      child: Image.asset("assets/images/C.png"),
                                    ),
                                     Column(children: [Text("${utf8.decode(cow.cattleId!.runes.toList())}"), Text("লিঙ্গ: ${cow.gender}")]),
                                     Column(children: [
                                       ElevatedButton(onPressed: () {
                                         Get.to(CowDetails(cow: cow,));
                                       }, child: Text("বিস্তারিত")),
                                       SizedBox(height: 10,),
                                       ElevatedButton(onPressed: () {
                                         Get.to(AddMilk(cow: cow));
                                       }, child: Text("   দুধ  "))
                                     ]),
                                   ],
                                 ),
                               ),
                             ),
                           );
                         },
                       ),
                     ),
                     SizedBox(height: 80,)
                   ],
                 );
               }
               else{
                 return Text("ABAR ReStart Diye Dekhen (3");
               }
            },
            listener: (context, state) {
            },
          ),
        ),


        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigator?.push(MaterialPageRoute(builder: (context) => AddCow(),));
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }

