
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/deseaseModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/medicineModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/vaccineModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Model/COWModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/cowDetails.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/BuildTextAndDateField.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/PopUpMessage.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/Update_Medicine_Disease_Vaccine/Update_Disease.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/Update_Medicine_Disease_Vaccine/Update_Medicine.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/Update_Medicine_Disease_Vaccine/Update_Vaccine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IndividualFieldShowSinglePerameter extends StatefulWidget {
  final String index;
  final COW? cow;
  final String imgAddress;
  final String title;
  final String value;

  IndividualFieldShowSinglePerameter({super.key,
    required this.index,
    required this.cow,
    required this.imgAddress,
    required this.title,
    required this.value,
  });

  @override
  State<IndividualFieldShowSinglePerameter> createState() => _IndividualFieldShowSinglePerameterState();
}

class _IndividualFieldShowSinglePerameterState extends State<IndividualFieldShowSinglePerameter> {
  Future showTextInputFieldPopup(BuildContext context) async {
    final controller = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min, // This ensures the content takes less vertical space.
            children: [

              // Basic Info Part

              widget.index=="age"?
              buildTextField("Age", controller, "Enter age","number") :
              widget.index=="origin"?
              DropdownTextField(
                title: "Origin",
                items: ["Local", "Imported"],
                controller: controller,
              ):
              widget.index=="color"?
              buildTextField("Color", controller, "Enter Color","text"):
              widget.index == "gender"?
              DropdownTextField(
                title: "Gender",
                items: ["Female", "Male"],
                controller: controller,
              ):
              widget.index == "milkYield"?
              buildTextField("Milk Yield", controller, "Enter Milk Yield","number"):
              widget.index == "weight"?
              buildTextField("Weight", controller, "Enter Weight","number"):
              widget.index == "breedingRate"?
              buildTextField("Breeding Rate", controller, "Enter Breeding Rate","number"):
              widget.index == "helthStatus"?
              DropdownTextField(
                title: "Health Status",
                items: ["Good", "Sick","Natural"],
                controller: controller,
              ):
              widget.index == "currentVaccineDose"?
              buildTextField("Current Vaccine Dose", controller, "Enter Current Vaccine Dose","number"):
              widget.index == "provableHeatDate"?
              buildDateField("Provable Heat Date",  controller):

              widget.index == "heatStatus"?
              DropdownTextField(
                title: "Heat Status",
                items: ["No","Yes"],
                controller: controller,
              ):
              widget.index == "semenPushStatus"?
              DropdownTextField(
                title: "Semen Push Status",
                items: ["No","Yes"],
                controller: controller,
              ):
              widget.index == "pregnantDate"?
              buildDateField("Pregnant Date",  controller):
              widget.index == "purchaseDate"?
              buildDateField("Purchase Date",  controller):
              widget.index == "deliveryStatus"?
              DropdownTextField(
                title: "Delivery Status",
                items: ["Yes","No"],
                controller: controller,
              ):
              widget.index == "deliveryDate"?
              buildDateField("Delivery Date",  controller):
              Container()



              // Health Part
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Save the changes to the text field and close the popup.
                    String value = controller.text.trim();

                    if (value.length > 0) {
                      // Handle saving the value here.
                      if(widget.index == "age"){  widget.cow?.age = int.parse(value);  submitData();  }
                      else if(widget.index == "purchaseDate"){  widget.cow?.purchaseDate = value;  submitData();  }
                      else if(widget.index == "origin"){  widget.cow?.origin = value;  submitData();  }
                      else if(widget.index == "weight"){  widget.cow?.weight = value;  submitData();  }
                      else if(widget.index == "milkYield"){  widget.cow?.milkYield = value;  submitData();  }
                      else if(widget.index == "color"){  widget.cow?.color = value;  submitData();  }
                      else if(widget.index == "breedingRate"){  widget.cow?.breedingRate = value;  submitData();  }
                      else if(widget.index == "gender"){  widget.cow?.gender = value;  submitData();  }
                      else if(widget.index == "helthStatus"){  widget.cow?.helthStatus = value;  submitData();  }
                      else if(widget.index == "provableHeatDate"){  widget.cow?.provableHeatDate = value;  submitData();  }
                      else if(widget.index == "heatStatus"){  widget.cow?.heatStatus = value;  submitData();  }
                      else if(widget.index == "semenPushStatus"){  widget.cow?.semenPushStatus = value;  submitData();  }
                      else if(widget.index == "pregnantDate"){  widget.cow?.pregnantDate = value;  submitData();  }
                      else if(widget.index == "deliveryStatus"){  widget.cow?.deliveryStatus = value;  submitData();  }
                      else if(widget.index == "deliveryDate"){  widget.cow?.deliveryDate = value;  submitData();  }
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }


  void submitData() async {
    print("HELLO HELLO");
    final url = Uri.parse('${AppBaseURL.BaseUrl}cowUpdate/');
    final data = {
      "id": widget.cow?.id,
      "cattle_id": widget.cow?.cattleId.toString(),
      "purchase_date": widget.cow?.purchaseDate.toString(),
      "age": widget.cow?.age.toString(),
      "color": widget.cow?.color.toString(),
      "date_of_birth": widget.cow?.dateOfBirth.toString(),
      "breeding_rate": widget.cow?.breedingRate.toString(),
      "weight": widget.cow?.weight.toString(),
      "milk_yield": widget.cow?.milkYield.toString(),
      "origin": widget.cow?.origin.toString(),
      "gender": widget.cow?.gender.toString(),
      "helth_status": widget.cow?.helthStatus.toString(),
      "provable_heat_date": widget.cow?.provableHeatDate.toString(),
      "heat_status": widget.cow?.heatStatus.toString(),
      "actual_heat_date": widget.cow?.actualHeatDate.toString(),
      "semen_push_status": widget.cow?.semenPushStatus.toString(),
      "pregnant_date": widget.cow?.pregnantDate.toString(),
      "delivery_status": widget.cow?.deliveryStatus.toString(),
      "delivery_date": widget.cow?.deliveryDate.toString(),
      "desease": widget.cow?.desease,
      "medicine": widget.cow?.medicine,
      "vaccine": widget.cow?.vaccine,
    };

    String jsonData = jsonEncode(data);
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );
      final Map<String, dynamic> responseMap = json.decode(response.body);
      if (response.statusCode == 200) {

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => CowDetails(cow: widget.cow),
          ),
        );
        PopupMessage(context,"Save",responseMap['message']);
        print(responseMap['message']);
      }else {
        print("ERROR FROM ELSE");
        PopupMessage(context,"Error",responseMap['message']);
        print(response.statusCode);
      }
    } catch (e) {
      print("ERROR FROM Catch");
      PopupMessage(context,"Error","Update Failed");
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffe3d9d9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              SvgPicture.asset(widget.imgAddress, height: 20),
              const SizedBox(width: 20),
              Text("${widget.title}"),
              Spacer(),
              IconButton( onPressed: () => showTextInputFieldPopup(context), icon: Icon(Icons.edit , color: Colors.green,)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 40),
            Text(
              widget.value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff733939),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

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
}


Widget messafe(){
  return AlertDialog(
    title: Text('Login successful!'),
    content: Text('You are now logged in.'),
  );
}

class IndividualFieldShowListPerameter extends StatefulWidget {
  final String imgAddress;
  final COW? cow;
  final String title;
  final String index;
  final List<String> value;

  IndividualFieldShowListPerameter({super.key,
    required this.imgAddress,
    required this.title,
    required this.value,
    required this.index,
    required this.cow,
  });

  @override
  State<IndividualFieldShowListPerameter> createState() => _IndividualFieldShowListPerameterState();
}

class _IndividualFieldShowListPerameterState extends State<IndividualFieldShowListPerameter> {



  List<MEDICINE> medicineAvailableChips = [];
  List<MEDICINE> selectedChips = [];




  void _showChipOFMedicine() async{
    final urlMedicine = Uri.parse('${AppBaseURL.BaseUrl}allmedicine/');
    try{
      final responseMedicine = await http.get(urlMedicine);
      if (responseMedicine.statusCode == 200) {
        final List<dynamic> medicineData = json.decode(responseMedicine.body);

        List<MEDICINE> medicine = medicineData.map((json) => MEDICINE.fromJson(json)).toList();
        medicineAvailableChips = medicine;
      }
    }
    catch(e){
      print(e.toString());
      throw Exception('Failed to load data');
    }


    showDialog(
      context: context,
      builder: (context) => ChipSelectionDialog(
        availableChips: medicineAvailableChips,
        selectedChips: selectedChips,
        cow : widget.cow,
        onChipSelectionChanged: (selectedChips) {
          setState(() {
            selectedChips = selectedChips;
          });
        },
      ),
    );
  }


  List<VACCINE> vaccineAvailableChips = [];
  List<VACCINE> selectedChipsVaccine = [];


  void _showChipOFVaccine() async{

    final urlVaccine = Uri.parse('${AppBaseURL.BaseUrl}allvaccine/');
    try {
      final responseVaccine = await http.get(urlVaccine);
      if (responseVaccine.statusCode == 200) {
        print("////  VACCINE DATA COMES /////////");
        final List<dynamic> vaccineData = json.decode(responseVaccine.body);

        List<VACCINE> vaccines = vaccineData.map((json) => VACCINE.fromJson(json)).toList();
        vaccineAvailableChips = vaccines;
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data');
    }




    showDialog(
      context: context,
      builder: (context) => VaccineSelectionDialog(
        availableChips: vaccineAvailableChips,
        selectedChips: selectedChipsVaccine,
        cow : widget.cow,
        onChipSelectionChanged: (selectedChipsVaccine) {
          setState(() {
            selectedChipsVaccine = selectedChipsVaccine;
          });
        },
      ),
    );

  }

  List<DESEASE> diseaseAvailableChips = [];
  List<DESEASE> selectedChipsdisease = [];

  void _showChipOFDisease() async{

    final urlDisease = Uri.parse('${AppBaseURL.BaseUrl}alldesease/');
    try {
      final responseDisease = await http.get(urlDisease);
      if (responseDisease.statusCode == 200) {
        print("////  disease DATA COMES /////////");
        final List<dynamic> diseaseData = json.decode(responseDisease.body);

        List<DESEASE> diseases = diseaseData.map((json) => DESEASE.fromJson(json)).toList();
        diseaseAvailableChips = diseases;
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data');
    }



    showDialog(
      context: context,
      builder: (context) => DiseaseSelectionDialog(
        availableChips: diseaseAvailableChips,
        selectedChips: selectedChipsdisease,
        cow : widget.cow,
        onChipSelectionChanged: (selectedChipsdisease) {
          setState(() {
            selectedChipsdisease = selectedChipsdisease;
          });
        },
      ),
    );

  }

  void nothing() {}


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffe3d9d9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              SvgPicture.asset(widget.imgAddress, height: 20),
              const SizedBox(width: 20),
              Text(widget.title),
              Spacer(),
              IconButton( onPressed: () => widget.index == "medicine"? _showChipOFMedicine() : widget.index == "vaccine" ? _showChipOFVaccine() : widget.index == "desease"? _showChipOFDisease() : nothing() , icon: Icon(Icons.edit , color: Colors.green,)),
              // IconButton( onPressed: () => showSelectedInputFieldPopup(context), icon: Icon(Icons.edit , color: Colors.green,)),
            ],

          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 40),
            // ...text(value),
            text(widget.value),

            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }


}


Widget text(List<String> l) {
  if (l.isNotEmpty) {
    List<Widget> textWidgets = l.map((item) {
      return Row(
        children: [
          Container(height: 5, width: 5, color: Colors.black),
          SizedBox(width: 5,),
          Text("${utf8.decode(item!.runes.toList())}", style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff733939),
          ),
          ),
        ],
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: textWidgets,
    );
  } else {
    return Container();
  }
}




