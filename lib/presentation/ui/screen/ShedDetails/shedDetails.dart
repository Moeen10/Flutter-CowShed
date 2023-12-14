import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/Cubit/shedCubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/Cubit/shedState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/Quality/Quality.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/image_base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/SizeDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShedDetails extends StatelessWidget {
  ShedDetails({Key? key}) : super(key: key);
  List<String> sensorNames = [
    'তাপমাত্রা',
    'আর্দ্রতা',
    'আলোর ঘনত্ব',
    'অ্যামোনিয়া',
  ];
  List<String> ekok = [
    "℃",
    "%",
    "Lux",
    "ppm"
  ];

  List<String> sensorCode =[
    "151",
    "152",
    "155",
    "154"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("শেড")),

      ),
      drawer: SideDrawer(),
      body: BlocProvider(
        create: (context) => ShedCubit(),
        child: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<ShedCubit>(context);

            return BlocConsumer<ShedCubit, ShedState>(
              bloc: cubit,
              builder: (context, state){
                if(state is LoadingState){
                  return LoadingIndicator();
                }
                else if (state is SuccessState){

                  double? tem = 0.0 ;
                  double? amo = 0.0 ;
                  double? hum = 0.0 ;
                  double? illuminance = 0.0 ;
                  for(int i = 0; i<4;i++){
                    if(state.latestSensorModel.data?[i]?.sensorName == "Temp"){
                      tem = state.latestSensorModel.data?[i]?.value ;
                    }
                    else if(state.latestSensorModel.data?[i]?.sensorName == "Amo"){
                      amo = state.latestSensorModel.data?[i]!.value! ;
                    }
                    else if(state.latestSensorModel.data?[i]?.sensorName == "Hum"){
                      hum = state.latestSensorModel.data?[i]?.value ;
                    }
                    else if(state.latestSensorModel.data?[i]?.sensorName == "Illuminance"){
                      illuminance = state.latestSensorModel.data?[i]?.value ;
                    }
                  }


                  List<dynamic> value = [
                    tem,
                    hum,
                    illuminance,
                    amo,
                  ];


                  List<String> formattedDate = [];
                  // Assuming state.latestSensorModel.data is a List with at least 3 elements
                  for (int i = 0; i < 4; i++) {
                    String inputDateString = state.latestSensorModel.data?[i]?.timeime ?? "0";
                    DateTime dateTime = DateTime.parse(inputDateString);

                    formattedDate.add(DateFormat("h:mm a yyyy-MM-dd").format(dateTime));
                  }

                  List<dynamic> dateValue = [
                    formattedDate[0],
                    formattedDate[3],
                    formattedDate[1],
                    formattedDate[2]
                  ];

                  return RefreshIndicator(
                    onRefresh: () async {
                      await cubit.fetchDataFromAPI();
                    },
                    child: Center(
                      child:  ListView.builder(
                        itemCount: 4, // Number of cards you want to display
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(EnvironmentQuality(
                                sensorCode: sensorCode[index],
                                sensorType: sensorNames[index],
                                sensorEkok: ekok[index],
                                imageURL: ImageURL.Shedpage[index],
                              ),);
                            },
                            child: Card(
                                margin: EdgeInsets.only(left: 20,top: 15,bottom: 0,right: 20),
                                child: SizedBox(
                                  height: 130,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(height: 40,ImageURL.Shedpage[index],fit:BoxFit.fill ),

                                            Text(sensorNames[index],style: TextStyle(fontSize: 25,color: Color(0xff373737)),)
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("${value[index]} ${ekok[index]}",style: TextStyle(fontSize: 25,color: Color(0xff00741E),fontWeight: FontWeight.bold),),
                                              Text("${dateValue[index]}",style: TextStyle(color: Color(0xff00741E),fontWeight: FontWeight.bold))
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                else{
                  return Container();
                }
              },
              listener: (context, state) {},
            );
          },
        ),
      ),
      );
  }
}



