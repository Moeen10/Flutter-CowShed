
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/DeviceWiseSensor/deviceWiseSensor.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/image_base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/SizeDrawer.dart';
import 'package:flutter/material.dart';

class DeviceControlHomePage extends StatelessWidget {
  const DeviceControlHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ডিভাইস কন্ট্রোল"),
      ),
      drawer:SideDrawer() ,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(ImageURL.deviceControllOutsideImage),
                    Image.asset(ImageURL.deviceControllInnersideImage),
                  ],
                ),
                Text("কন্ট্রোল বোর্ড",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DeviceWiseSensors(),));
            },
          ),
        ],)
      ),
    );
  }
}
