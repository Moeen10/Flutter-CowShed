import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/ManualSet/individualManualSet.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/BuildTextAndDateField.dart';
import 'package:flutter/material.dart';

class SetManualCondition extends StatelessWidget {
   SetManualCondition({Key? key}) : super(key: key);

  List<String> Title  = [
    "ফ্যান এর জন্য সর্বোচ্চ তাপমাত্রা",
    "ফ্যান এর জন্য সর্বোচ্চ আদ্রতা",
    "ফ্যান এর জন্য সর্বোচ্চ অ্যামোনিয়া",

    "স্প্রিংকলার এর জন্য সর্বোচ্চ তাপমাত্রা",
    "স্প্রিংকলার এর জন্য সর্বনিম্ন আদ্রতা",

    "সাইরেন এর জন্য সর্বোচ্চ তাপমাত্র",
    "সাইরেন এর জন্য সর্বোচ্চ আদ্রতা",
    "সাইরেন এর জন্য সর্বোচ্চ অ্যামোনিয়া",

  ];

   List<int> Id = [ 4, 5, 6, 8 , 9,  10,  11,  12 ];


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("সেন্সর এর মান সেট ")),
      body:
      ListView.builder(
        itemCount: Title.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 4.0,
              child: InkWell(
                onTap: () {
                  // Handle tap on each item
                  Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualFielSetValueManually(Id:Id[index], title: Title[index],)));
                  print(Title[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${Title[index]}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Set ${Title[index]} manually',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
