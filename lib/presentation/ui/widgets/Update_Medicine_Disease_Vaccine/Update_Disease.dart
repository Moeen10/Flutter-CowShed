import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/deseaseModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/medicineModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Model/COWModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/cowDetails.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/cowProfile.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/PopUpMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Medicines POPUP SECTIONS

class DiseaseSelectionDialog extends StatefulWidget {
  final List<DESEASE> availableChips;
  final List<DESEASE> selectedChips;
  final COW? cow;
  final void Function(List<DESEASE>) onChipSelectionChanged;

  const DiseaseSelectionDialog({
    Key? key,
    required this.availableChips,
    required this.selectedChips,
    required this.cow,
    required this.onChipSelectionChanged,
  }) : super(key: key);

  @override
  State<DiseaseSelectionDialog> createState() => _DiseaseSelectionDialogState();
}

class _DiseaseSelectionDialogState extends State<DiseaseSelectionDialog> {

  List<DESEASE> _selectedChips = [];
  List<String> desease_name = [];
  @override
  void initState() {
    super.initState();
    _selectedChips = widget.selectedChips;
  }

  void _handleChipSelection(DESEASE chipValue) {
    print("*****************");
    print(chipValue.deseaseName);
    setState(() {
      if (_selectedChips.contains(chipValue)) {
        _selectedChips.remove(chipValue);

      } else {
        desease_name.add(chipValue.deseaseName!);
        _selectedChips.add(chipValue);
      }
    });
    widget.onChipSelectionChanged(_selectedChips);
    print('Selected chips: ${_selectedChips.join(', ')}');
  }

  Color _getChipColor(DESEASE chipValue) {
    return _selectedChips.contains(chipValue) ? Colors.yellow : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Disease for ${widget.cow?.cattleId}'),
      content: SingleChildScrollView(
        child: Wrap(
          children: widget.availableChips.map((chipValue) => ChoiceChip(
            label: Text('${utf8.decode(chipValue.deseaseName!.runes.toList())}'),
            selected: _selectedChips.contains(chipValue),
            onSelected: (selected) => _handleChipSelection(chipValue),
            selectedColor: Colors.yellow,
          )).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            print("--------------------");
            print(_selectedChips);
            _selectedChips.clear();
            Navigator.of(context).pop();
            widget.onChipSelectionChanged(_selectedChips);
            print("///////////////////////");
            submitData();
          },
          child: Text('OK'),
        ),
      ],
    );
  }

  void submitData() async {
    widget.cow?.desease = desease_name;
    int len  =widget.cow!.desease?.length ?? 0;
    for(int i = 0;i<len;i++){
      String? name = widget.cow?.desease![i];
      widget.cow?.desease![i]=   utf8.decode(name!.runes.toList());
    }
    // print("Disease : ");
    // for(int i = 0;i<len;i++){
    //   print(widget.cow!.desease![i]);
    // }


    // For medicine

    int len2  =widget.cow!.medicine?.length ?? 0;
    for(int i = 0;i<len2;i++){
      String? nameM = widget.cow?.medicine![i];
      widget.cow?.medicine![i]=   utf8.decode(nameM!.runes.toList());
    }
    // print("Medicine : ");
    // for(int i = 0;i<len2;i++){
    //
    //   print(widget.cow!.medicine![i]);
    // }


    int len3  =widget.cow!.vaccine?.length ?? 0;
    for(int i = 0;i<len3;i++){
      String? nameV = widget.cow?.vaccine![i];
      widget.cow?.vaccine![i]=   utf8.decode(nameV!.runes.toList());
    }
    // print("Vaccine : ");
    // for(int i = 0;i<len3;i++){
    //
    //   print(widget.cow!.vaccine![i]);
    // }




    print("SUBMIT From Update Disease");

    widget.cow?.desease = desease_name;
    print("^^^^^^^^^^^^");
    print(widget.cow?.desease);
    print(widget.cow?.medicine);
    print(widget.cow?.vaccine);
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
        print(responseMap['message']);
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => CowDetails(cow: widget.cow),
        //   ),
        // );
        // PopupMessage(context,"Done",responseMap['message']);
        Get.to(CowProfile());

      }else {
        print("ERROR FROM ELSE");
        PopupMessage(context,"Error",responseMap['message']);
        print(response.statusCode);
      }
    } catch (e) {
      print("ERROR FROM Catch");
      PopupMessage(context,"Error","Update Issue");

      throw Exception('Failed to load data');
    }
  }
}


