import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/AdjustWaterSprinkler/Cubit/adjustWaterSpinklerCubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/AdjustWaterSprinkler/Cubit/adjustWaterSpinklerState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/image_base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class WaterSprinkler extends StatefulWidget {
  WaterSprinkler({Key? key}) : super(key: key);

  @override
  State<WaterSprinkler> createState() => _WaterSprinklerState();
}

class _WaterSprinklerState extends State<WaterSprinkler> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("পানি ছিটানো")),
      body: BlocProvider(
        create: (context) => AdjustWaterSpinklerCubit(),
        child: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<AdjustWaterSpinklerCubit>(context);

            return BlocConsumer<AdjustWaterSpinklerCubit, AdjustWaterSpinklerState>(
              bloc: cubit,
              builder: (context, state) {
                if (state is LoadingState) {
                  return Center(
                    child: LoadingIndicator(),
                  );
                } else if (state is PeripheralDeviceStatusDataState) {
                  bool isSwitched = state.available;
                  return Center(
                    child: Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(ImageURL.waterSprinkler),
                          Text(
                            'পানি ছিটানো ${isSwitched ? 'চালু' : 'বন্ধ'}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          isLoading
                              ? CircularProgressIndicator()
                              : Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              print(value);
                              cubit.toggleSwitch(state.modelData,value); // Dispatch the event
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
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

