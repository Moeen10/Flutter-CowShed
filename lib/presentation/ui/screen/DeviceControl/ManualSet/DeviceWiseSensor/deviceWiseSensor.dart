import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/AdjustFan/adjustFan.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/DeviceWiseSensor/Cubit/Cubits.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/DeviceWiseSensor/Cubit/States.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/light.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/scheduler.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/setManualCondition.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/AdjustWaterSprinkler/waterSprinkler.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/image_base_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class DeviceWiseSensors extends StatelessWidget {
  final List<Color> itemColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  final List<String> sensorsName = [
    "পানি ছিটানো",
    "পাখা সামঞ্জস্য করুন",
  ];

  final List<String> imageURL = [
    ImageURL.waterSprinkler,
    ImageURL.adjustFan,
  ];



  DeviceWiseSensors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("কন্ট্রোল বোর্ড"),
        centerTitle: true,
      ),
      body:
      BlocProvider(
        create: (context) => DeviceWiseSensorCubit(),
        child: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<DeviceWiseSensorCubit>(context);

            return BlocConsumer<DeviceWiseSensorCubit, DeviceWiseSensorCubitState>(
              bloc: cubit,
              builder: (context, state) {
                if(state is LoadingState){
                  return const LoadingIndicator();
                }
                else if (state is SuccessState){

                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns in each row
                              crossAxisSpacing: 0.0, // Spacing between columns
                              mainAxisSpacing: 8.0, // Spacing between rows
                            ),
                            itemCount: sensorsName.length, // Total number of items in the grid
                            itemBuilder: (context, index) {
                              // You can customize the contents of each grid item (Container) here
                              return GestureDetector(
                                onTap: () {
                                  if(index==0){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WaterSprinkler(),
                                      ),
                                    );
                                  }
                                  if(index==1){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdjustFan(),
                                      ),
                                    );
                                  }
                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(ImageURL.deviceControllOutsideImage),
                                          Image.asset(imageURL[index]),
                                        ],
                                      ),
                                    ),
                                    Text("${sensorsName[index]}" , style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              );
                            },
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("বর্তমান মোড  : ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                              Text("${state.value=="1" ? "অটো" : "ম্যানুয়াল" }",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.green),),

                            ],
                          ),
                          ElevatedButton(onPressed: (){
                            cubit.changeMode(state.value);
                          }, child: Text("মোড পরিবর্তন করুন")),
                          Spacer(),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SetManualCondition(),));
                                },
                                child: Text("ম্যানুয়াল ভ্যালু সেট" ,style: TextStyle(fontSize: 20),)),
                          ),
                          SizedBox(height: 20,),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Scheduler(),));
                                },
                                child: Text("সময়সূচী" ,style: TextStyle(fontSize: 20),)),
                          ),
                          SizedBox(height: 100,)
                        ],
                      ),
                    );

                }
                else{
                  return Container(
                    child: Text("JHABVSIFBSAf"),
                  );
                }
              },
              listener: (context, state) {
                // Do something when the state changes.
                if(state is ErrorMessageState){
                  Get.showSnackbar(
                    GetSnackBar(
                      title: "Error",
                      icon: const Icon(Icons.done),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                      messageText: Text(
                        'Cannot Change',
                        style: TextStyle(color: Colors.yellow), // Set your desired text color here
                      ),
                    ),
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
