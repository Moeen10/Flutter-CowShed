import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Cubit/addCow_cubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Cubit/addCow_states.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/deseaseModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/medicineModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/vaccineModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/cowProfile.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/BuildTextAndDateField.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/PopUpMessage.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/SizeDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class AddCow extends StatefulWidget {
  AddCow({Key? key}) : super(key: key);
  @override
  State<AddCow> createState() => _AddCowState();
}

class _AddCowState extends State<AddCow> {

  int currentSection = 0;

  final TextEditingController originController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController cattleIDController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController breedingRateController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController milkYieldController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController nextVaccinedDate = TextEditingController();
  final TextEditingController purchaseDateController = TextEditingController();
  final TextEditingController healthStatusController = TextEditingController();
  final TextEditingController vaccinedController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController medicineController = TextEditingController();
  final TextEditingController currentVaccineController = TextEditingController();
  final TextEditingController currentVaccineDoseController = TextEditingController();
  final TextEditingController nextVaccineDateController = TextEditingController();
  final TextEditingController pregnantDateController = TextEditingController();
  final TextEditingController deliveryDateController = TextEditingController();
  final TextEditingController semenPushDateController = TextEditingController();
  final TextEditingController semenPushStatusController = TextEditingController();
  final TextEditingController acctualHeatController = TextEditingController();
  final TextEditingController provableHeatDateController = TextEditingController();
  final TextEditingController deliveryStatusController = TextEditingController();
  final TextEditingController pregnantStatusController = TextEditingController();
  final TextEditingController heatStatusController = TextEditingController();
  final TextEditingController dropController = TextEditingController();
  late String selectedColor;

  DateTime pickedDate = DateTime.now();

  Future<void> _selectDateNextVaccine(BuildContext context , TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        pickedDate = picked;
      });
      controller.text = picked.toString().split(' ')[0];
    } else {
      controller.text = ''; // Set it to an empty string if nothing is picked
    }
  }

  List<String> tags = [];
  List<int> tagsPK = [];
  List<String> tags2 = [];
  List<int> tags2PK = [];
  List<String> tags3 = [];
  List<int> tags3PK = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("গরু যোগ করুন"),
      ),
      drawer: SideDrawer(),
      body:
      BlocProvider(
        create: (context) => AllCow_Cubit(),
        child: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<AllCow_Cubit>(context);

            return BlocConsumer<AllCow_Cubit, AddCowStates>(
              bloc: cubit,
              builder: (context, state){
                if (state is Loading){
                  return LoadingIndicator();
                }
                else if( state is ErrorState){
                  return  Center(child: Text("${state.errorMessage}"));
                }
                else if( state is DeseaseAndVaccineAndMedicineList){
                  return  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: buildSectionSwitchButton(0, "মৌলিক তথ্য"),
                                ),
                                Expanded(
                                  child: buildSectionSwitchButton(1, "স্বাস্থ্য"),
                                ),
                                Expanded(
                                  child: buildSectionSwitchButton(2, "প্রজনন"),
                                ),
                              ],
                            ),
                          ),
                          buildSection(currentSection,state.desease,state.medicine,state.vaccine),
                        ],
                      ),
                    ),
                  );
                }
                else{
                  return Container(child: Center(child: Text("What???????")),);
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

  Widget buildButton(currentSection) {
    return currentSection == 3
        ? SizedBox(
      width: double.infinity,
      height: 60,
      child: Padding(

        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: submitData,
          child: Text("Submit"),
        ),
      ),
    )
        : Container();

  }

  Widget buildSectionSwitchButton(int section, String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          currentSection = section;
        });
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: currentSection == section ? Colors.cyan : null,
        elevation: 0,
        minimumSize: Size(double.infinity, 50),
      ),

      child: Text(label),
    );
  }

  Widget buildSection(int section ,  List<DESEASE> desease, List<MEDICINE> medicine,List<VACCINE>vaccine) {

    if (section == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("Upload Image ear kaj baki",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          buildDateField("ক্রয়ের তারিখ",purchaseDateController),
          DropdownTextField(
            title: "জাত",
            items: ["Local", "Imported"],
            controller: originController,
          ),
          DropdownTextField(
            title: "লিঙ্গ",
            items: ["Female", "Male"],
            controller: genderController,
          ),
          buildTextField("গরুর আইডি নং",cattleIDController, "CTL-101","text"),
          buildTextField("বয়স",ageController, "10","number"),
          buildDateField("জন্ম তারিখ",dateOfBirthController),
          buildTextField("রং",colorController, "White","text"),
          buildTextField("প্রজননের হার",breedingRateController, "2","number"),
          buildTextField("ওজন",weightController, "85","number"),
          buildTextField("Milk Yield",milkYieldController, "15","number"),
        ],
      );
    }

    else if (section == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("রোগ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
          Container(
            width: double.infinity,
            height: 60,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 1),
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: tags.map((tag) {
                  return Chip(
                    backgroundColor: Color(0xffB8F4FF),
                    label: Text(tag, style: TextStyle(color: Color(0xff777777)),),
                    onDeleted: () {
                      setState(() {
                        tags.remove(tag);

                        tagsPK.remove(desease.firstWhere((d) => utf8.decode(d.deseaseName!.runes.toList()) == tag).id);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          ChipsChoice<int>.multiple(
            value: tagsPK,
            onChanged: (val) {
              setState(() {
                tagsPK = val;
                tags = tagsPK
                    .map((id) {
                  final selectedDisease = desease.firstWhere(
                          (disease) => disease.id == id, orElse: () => DESEASE(id: id, deseaseName: 'N/A'));
                  return  utf8.decode(selectedDisease.deseaseName!.runes.toList())   ?? 'N/A';
                })
                    .toList();
              });
            },
            choiceItems: C2Choice.listFrom<int, DESEASE>(
              source: desease,
              value: (index, item) => item.id!,
              label: (index, item) =>  utf8.decode(item.deseaseName!.runes.toList()),
            ),
          ),


          Text("ওষুধ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
          Container(
            width: double.infinity,
            height: 60,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 1),
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: tags2.map((tag) {
                  return Chip(
                    backgroundColor: Color(0xffB8F4FF),
                    label: Text(tag, style: TextStyle(color: Color(0xff777777)),),
                    onDeleted: () {
                      setState(() {
                        tags2.remove(tag);
                        tags2PK.remove(medicine.firstWhere((m) => utf8.decode(m.medicineName!.runes.toList())  == tag).id);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          ChipsChoice<int>.multiple(
            value: tags2PK,
            onChanged: (val) {
              setState(() {
                tags2PK = val;
                tags2 = tags2PK
                    .map((id) {
                  final selectedMedicine = medicine.firstWhere(
                          (medicine) => medicine.id == id, orElse: () => MEDICINE(id: id, medicineName: 'N/A'));
                  return utf8.decode(selectedMedicine.medicineName!.runes.toList())   ?? 'N/A';
                })
                    .toList();
              });
            },
            choiceItems: C2Choice.listFrom<int, MEDICINE>(
              source: medicine,
              value: (index, item) => item.id!,
              label: (index, item) => utf8.decode(item.medicineName!.runes.toList()) ,
            ),
          ),

          Text("টিকা",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
          Container(
            width: double.infinity,
            height: 60,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 1),
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: tags3.map((tag) {
                  return Chip(
                    backgroundColor: Color(0xffB8F4FF),
                    label: Text(tag, style: TextStyle(color: Color(0xff777777)),),
                    onDeleted: () {
                      setState(() {
                        tags3.remove(tag);
                        tags3PK.remove(vaccine.firstWhere((v) => utf8.decode(v.vaccineName!.runes.toList())  == tag).id);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          ChipsChoice<int>.multiple(
            value: tags3PK,
            onChanged: (val) {
              setState(() {
                tags3PK = val;
                tags3 = tags3PK
                    .map((id) {
                  final selectedVaccine = vaccine.firstWhere(
                          (vaccine) => vaccine.id == id, orElse: () => VACCINE(id: id, vaccineName: 'N/A'));
                  return utf8.decode(selectedVaccine.vaccineName!.runes.toList())  ?? 'N/A';
                })
                    .toList();
              });
            },
            choiceItems: C2Choice.listFrom<int, VACCINE>(
              source: vaccine,
              value: (index, item) => item.id!,
              label: (index, item) => utf8.decode(item.vaccineName!.runes.toList()) ,
            ),
          ),


          DropdownTextField(
            title: "স্বাস্থ্য অবস্থা",
            items: ["Good", "Sick","Natural"],
            controller: healthStatusController,
          ),
          buildTextField("বর্তমান ভ্যাকসিন",currentVaccineController, "Current vaccine","text"),
          buildTextField("বর্তমান ভ্যাকসিন ডোজ",currentVaccineDoseController, "Current vaccine dose","number"),
          buildDateField("পরবর্তী ভ্যাকসিন তারিখ",nextVaccineDateController),
        ],
      );
    }

    else if (section == 2) {
      return Column(
        children: [
          buildDateField("সম্ভাব্য হিটের তারিখ",provableHeatDateController),
          SizedBox(height: 10,),
          DropdownTextField(
            title: "স্বাস্থ্য অবস্থা",
            items: [ "Yes", "No"],
            controller: heatStatusController,
          ),
          SizedBox(height: 10,),
          buildDateField("প্রকৃত হিটের তারিখ",acctualHeatController),
          SizedBox(height: 10,),
          DropdownTextField(
            title: "সিমেন পুশ স্টেটাস",
            items: ["Yes", "No"],
            controller: semenPushStatusController,
          ),
          SizedBox(height: 10,),
          buildDateField("সিমেন পুশের তারিখ ",semenPushDateController),
          SizedBox(height: 10,),
          DropdownTextField(
            title: "গর্ভবতী অবস্থা",
            items: ["Yes", "No"],
            controller: pregnantStatusController,
          ),
          SizedBox(height: 10,),
          buildDateField("গর্ভবতী হওয়ার তারিখ",pregnantDateController),
          SizedBox(height: 10,),
          DropdownTextField(
            title: "ডেলিভারি অবস্থা",
            items: ["Yes", "No"],
            controller: deliveryStatusController,
          ),
          SizedBox(height: 10,),
          buildDateField("ডেভিভারির তারিখ",deliveryDateController),

          Center(child: buildButton(3)),

        ],
      );
    }
    else {
      return Container();
    }
  }

  Widget buildDateField(String Title , TextEditingController controllerName,){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
        SizedBox(height: 10,),
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border:Border.all(color: Color(0xff54A800),width: 2),
              color: Colors.white
          ),

          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [

                SvgPicture.asset(
                  "assets/images/calender.svg", // Replace with your SVG asset path
                  width: 24, // Adjust the width as needed
                  height: 24, // Adjust the height as needed
                ),
                Expanded(
                  child: TextField(
                    controller: controllerName,
                    onTap: () =>_selectDateNextVaccine(context,controllerName),
                    decoration:
                    InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),

                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void submitData() async{
    final url = Uri.parse('${AppBaseURL.BaseUrl}postCow/');

  print("NNNNNNNNNNNNNNNNNN");
  print(purchaseDateController.text.trim());
  String v = purchaseDateController.text.trim();
  if (v == null){
    print(888);
  }
  print(tags3PK);

    final data = {
      "cattle_id": cattleIDController.text,
      "purchase_date": purchaseDateController.text.trim(),
      "age": ageController.text,
      "color": colorController.text,
      "date_of_birth":dateOfBirthController.text,
      "breeding_rate":breedingRateController.text,
      "weight":weightController.text,
      "milk_yield":milkYieldController.text,
      "origin" : originController.text,
      "gender" : genderController.text,
      "helth_status":healthStatusController.text,
      "provable_heat_date":provableHeatDateController.text,
      "heat_status":heatStatusController.text,
      "actual_heat_date":acctualHeatController.text,
      "semen_push_status":semenPushStatusController.text,
      "pregnant_date":pregnantDateController.text,
      "delivery_status":deliveryStatusController.text,
      "delivery_date":deliveryDateController.text,
      "desease":tagsPK,
      "medicine":tags2PK,
      "vaccine":tags3PK,
      "active":"True"
    };

    String jsonData = jsonEncode(data);

    try{
      final response = await http.post(

        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 201) {

        await PopupMessage(context,"Done","Cow Create Successfully");
        await Future.delayed(Duration(seconds: 2));
        navigator!.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CowProfile(),), (route) => false);
      } else {
        print("ERROR FROM ELSE");
        final dynamic jsData = jsonDecode(response.body);
        print(jsData["message"]);
        final message = "Your message goes here!";

        PopupMessage(context,"Error",jsData["message"].toString());
      }
    }
    catch(e){
      print("ERROR FROM Catch");
      throw Exception('Failed to load data');
    }
  }
}
