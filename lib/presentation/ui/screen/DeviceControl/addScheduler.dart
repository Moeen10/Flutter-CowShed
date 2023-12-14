import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/scheduler.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddScheduler extends StatefulWidget {
  const AddScheduler({Key? key}) : super(key: key);

  @override
  State<AddScheduler> createState() => _AddSchedulerState();
}

class _AddSchedulerState extends State<AddScheduler> {
  Time _timeTo = Time(hour: 00, minute: 00, second: 00);
  Time _timeFrom = Time(hour: 00, minute: 00, second: 00);


  bool loading = false;
  void onTimeToChanged(Time newTime) {
    setState(() {
      _timeTo = newTime;
    });
  }

  void onTimeFromChanged(Time newTime) {
    setState(() {
      _timeFrom = newTime;
    });
  }

  String getFormattedTimeTo() {
    startTime = _timeTo.toString();
    startTime = startTime.replaceAll('TimeOfDay(', '').replaceAll(':', '').replaceAll(')', '');
    print(startTime);
    return _timeTo.format(context);
  }

  String getFormattedTimeFrom() {
    endTime = _timeFrom.toString();
    endTime = endTime.replaceAll('TimeOfDay(', '').replaceAll(':', '').replaceAll(')', '');
    print(endTime);
    return _timeFrom.format(context);
  }

  void submitTimesToBackend() async{
    loading = true;

    try {
      var response = await http.post(
        Uri.parse(AppBaseURL.ParameterStatusSet),
        headers: {
          "Authorization": "Bearer ${GetToken.token}",
        },
        body: {
          "parameter[]": "2-${startTime}",

        },
      );

      if (response.statusCode == 200) {
        print("POST request successful!");
        try {
          var response = await http.post(
            Uri.parse(AppBaseURL.ParameterStatusSet),
            headers: {
              "Authorization": "Bearer ${GetToken.token}",
            },
            body: {
              "parameter[]": "3-${endTime}",
            },
          );

          if (response.statusCode == 200) {
            print("POST request successful!");
            loading = false;
            Navigator.push(context, MaterialPageRoute(builder: (context) => Scheduler(),));
          } else {
            print("POST request failed with status: ${response.statusCode}");
            loading = false;
          }
        } catch (e) {
          print("Error during POST request: $e");
          loading = false;
        }
      } else {
        print("POST request failed with status: ${response.statusCode}");
        loading = false;
      }
    } catch (e) {
      print("Error during POST request: $e");
      loading = false;
    }
  }
  String endTime = '0000';
  String startTime = '0000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("সিডিউল সেট করেন"),centerTitle: true),
      body: loading ? LoadingIndicator()
      : SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      Text(
                        "শুরুর সময়",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        getFormattedTimeTo(),
                        textAlign: TextAlign.center,
                       style: TextStyle(fontSize: 52),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            showPicker(
                              showSecondSelector: true,
                              context: context,
                              value: _timeTo,
                              onChange: onTimeToChanged,
                              minuteInterval: TimePickerInterval.FIVE,
                              onChangeDateTime: (DateTime dateTime) {
                                debugPrint("[debug datetime]:  $dateTime");
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "সময় নির্বাচন করুন",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: Column(
                    children: [
                      Text(
                        "শেষ সময়",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        getFormattedTimeFrom(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 52),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            showPicker(
                              showSecondSelector: true,
                              context: context,
                              value: _timeFrom,
                              onChange: onTimeFromChanged,
                              minuteInterval: TimePickerInterval.FIVE,
                              onChangeDateTime: (DateTime dateTime) {
                                debugPrint("[debug datetime]:  $dateTime");
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "সময় নির্বাচন করুন",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const Divider(),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: submitTimesToBackend,
                  child: Text("জমা দিন"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
