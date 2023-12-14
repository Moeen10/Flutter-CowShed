import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/AdjustFan/Cubit/adjustFanCubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/AdjustFan/Cubit/adjustFanState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/image_base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdjustFan extends StatelessWidget {
  const AdjustFan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ফ্যান সামঞ্জস্য করুন")),
      body: BlocProvider(
        create: (context) => AdjustFanCubit(),
        child: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<AdjustFanCubit>(context);

            return BlocConsumer<AdjustFanCubit, AdjustFanState>(
              bloc: cubit,
              builder: (context, state) {
                if (state is LoadingState){
                  return Center(
                    child: LoadingIndicator(),
                  );
                }
                else if(state is PeripheralDeviceStatusDataState){
                  return Column(
                    children: [
                      SwitchWidget(fanSituation : state.available),
                    ],
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
              },
            );
          },
        ),
      ),
    );
  }
}

class SwitchWidget extends StatefulWidget {
  final List<bool> fanSituation;

  SwitchWidget({required this.fanSituation});

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  List<bool> isSwitched = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    isSwitched = widget.fanSituation;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            shrinkWrap: true,
            children: List.generate(6, (index) {
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    // Handle tap for index 0
                  } else if (index == 1) {
                    // Handle tap for index 1
                  } else if (index == 2) {
                    // Handle tap for index 2
                  }
                },
                child: buildFan(index),
              );
            }),
          ),
          ElevatedButton(onPressed: () async{
            var formData = {
              "peripheral_type": "1",
              "peripheral[]": "1-1",
              "peripheral[]": "2-1",
              "peripheral[]": "3-1",
              "peripheral[]": "4-1",
              "peripheral[]": "5-1",
              "peripheral[]": "6-1",
            };
            try {
              var response = await http.post(
                Uri.parse(AppBaseURL.PeripheralStatusSet),
                headers: {
                  "Authorization": "Bearer ${GetToken.token}",
                },
                body:  formData,
              );

              if (response.statusCode == 200) {
                Get.showSnackbar(
                  GetSnackBar(
                    title: "চালু হয়েছে",
                    icon: const Icon(Icons.not_interested),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                    messageText: Text(
                      '',
                      style: TextStyle(color: Colors.yellow), // Set your desired text color here
                    ),
                  ),
                );
              } else {
                print("111   object");
                Get.showSnackbar(
                  GetSnackBar(
                    title: "বাতিল",
                    icon: const Icon(Icons.not_interested),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                    messageText: Text(
                      'বাতিল হয়েছে',
                      style: TextStyle(color: Colors.yellow), // Set your desired text color here
                    ),
                  ),
                );
              }
            } catch (e) {
              print("Error during POST request: $e");
              Get.showSnackbar(
                GetSnackBar(
                  title: "বাতিল",
                  icon: const Icon(Icons.not_interested),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                  messageText: Text(
                    'বাতিল হয়েছে',
                    style: TextStyle(color: Colors.yellow), // Set your desired text color here
                  ),
                ),
              );
            }
          }, child: Text("সকল ফ্যান চালু করুন")),
          ElevatedButton(onPressed: () async{
            var formData = {
              "peripheral_type": "1",
              "peripheral[]": "1-0",
              "peripheral[]": "2-0",
              "peripheral[]": "3-0",
              "peripheral[]": "4-0",
              "peripheral[]": "5-0",
              "peripheral[]": "6-0",
            };
            try {
              var response = await http.post(
                Uri.parse(AppBaseURL.PeripheralStatusSet),
                headers: {
                  "Authorization": "Bearer ${GetToken.token}",
                },
                body: formData
              );

              if (response.statusCode == 200) {
                Get.showSnackbar(
                  GetSnackBar(
                    title: "বন্ধ হয়েছে",
                    icon: const Icon(Icons.not_interested),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 3),
                    messageText: Text(
                      '',
                      style: TextStyle(color: Colors.yellow), // Set your desired text color here
                    ),
                  ),
                );
              } else {
                Get.showSnackbar(
                  GetSnackBar(
                    title: "বাতিল",
                    icon: const Icon(Icons.not_interested),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                    messageText: Text(
                      'বাতিল হয়েছে',
                      style: TextStyle(color: Colors.yellow), // Set your desired text color here
                    ),
                  ),
                );
              }
            } catch (e) {
              Get.showSnackbar(
                GetSnackBar(
                  title: "বাতিল",
                  icon: const Icon(Icons.not_interested),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                  messageText: Text(
                    'বাতিল হয়েছে',
                    style: TextStyle(color: Colors.yellow), // Set your desired text color here
                  ),
                ),
              );
            }
          }, child: Text("সকল ফ্যান বন্ধ করুন")),

        ],
      ),
    );
  }

  Widget buildFan(int index) {
    return Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(ImageURL.adjustFan),

          Text(
            'পাখা ${index+1} ${isSwitched[index] ? 'চালু' : 'বন্ধ'}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          isLoading
              ? CircularProgressIndicator()
              : Switch(
            value: isSwitched[index],
            onChanged: (value) {
              setState(() {
                if (!isLoading) {
                  isLoading = true;
                  isSwitched[index] = value;
                  print("KI RE ${isSwitched[index]}");
                  sendPostRequest(index);
                }
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

  void sendPostRequest(int index) async {
    print("Device is ${index + 1} value is ${isSwitched[index]}");
    try {
      var response = await http.post(
        Uri.parse("https://cowshed.datasoft.aqualinkbd.com/apiV2/api3/peripheral-status-set"),
        headers: {
          "Authorization": "Bearer ${GetToken.token}",
        },
        body: {
          "peripheral[]": "${index + 1}-${isSwitched[index] ? '1' : '0'}",
          "peripheral_type": "1",
        },
      );

      if (response.statusCode == 200) {
        // Successful response
        print("POST request successful!");
      } else {
        // Handle error response
        print("POST request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any exceptions
      print("Error during POST request: $e");
    } finally {
      // Assuming `isLoading` is a variable that you are using in your Flutter state
      setState(() {
        isLoading = false;
      });
    }
  }


}
