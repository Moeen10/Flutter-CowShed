import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/Quality/Model/SensorWiseModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/image_base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class EnvironmentQuality extends StatefulWidget {
  final String sensorType;
  final String imageURL;
  final String sensorCode;
  final String sensorEkok;
  const EnvironmentQuality({
    Key? key,
    required this.sensorType,
    required this.sensorCode,
    required this.sensorEkok,
    required this.imageURL,
  }) : super(key: key);

  @override
  State<EnvironmentQuality> createState() => _EnvironmentQualityState();
}

class _EnvironmentQualityState extends State<EnvironmentQuality> {
  late bool loading = true;
  late SensorWiseModel latestSensorModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void>fetchData() async{
    final String url ="https://cowshed.datasoft.aqualinkbd.com/apiV2/api3/sensor-latest-value?number_of_value=3&sensor_id=${widget.sensorCode}&device_code=20230313902086";
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer ${GetToken.token}"},
      );
      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        latestSensorModel = SensorWiseModel.fromJson(
            jsonResponse);
        print(latestSensorModel);
        setState(() {
          loading = false;
          print(latestSensorModel.data?[0].value);
        });

      } else {
        // Print an error message if the request was not successful
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    }
    catch(e){
      print("Failed to fetch data. Status code: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:


      AppBar(
        title:  const Center(child: Text("Quality ")),
      ),
      body: loading
          ? LoadingIndicator()
          : Column(
        children: [
          Card(
            margin: EdgeInsets.only(left: 20,top: 20,bottom: 0,right: 20),
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 55,
                        width: 50,
                        child: SvgPicture.asset(widget.imageURL,fit:BoxFit.fill)
                    ),
                    SizedBox(width: 25,),
                    Text(widget.sensorType,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),)
                  ],
                ),
              ),
            ),

          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 10,),
                    Card(
                      margin: EdgeInsets.only(left: 20,top: 20,bottom: 0,right: 20),
                      child: SizedBox(
                        height: 65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 50,
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImageURL.clock,fit: BoxFit.cover,height:30),
                                  SizedBox(width: 10,),
                                  Text(  DateFormat('hh:mm a').format(
                                    DateTime.parse(latestSensorModel.data?[index].timeime ?? "2023-12-12 00:00:00"),
                                    ),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                            Container(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 10, // Set the desired diameter of the circle
                                    width: 10,  // Set the desired diameter of the circle
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,  // This sets the shape to a circle
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 2.0, // Border width
                                      ),
                                      color: Colors.green, // Background color
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("${latestSensorModel.data?[index].value} ${widget.sensorEkok}",style: TextStyle(color: Color(0xff09B256),fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
