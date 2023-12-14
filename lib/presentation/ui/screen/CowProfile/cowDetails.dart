import 'dart:convert';

import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/Model/COWModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/image_base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/IndividualFieldShowSinglePerameter.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/SizeDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CowDetails extends StatefulWidget {
   final COW? cow;
   CowDetails({Key? key, this.cow}) : super(key: key);
  @override

  State<CowDetails> createState() => _CowDetailsState();
}

class _CowDetailsState extends State<CowDetails> {
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(utf8.decode(("${widget.cow?.cattleId.toString()}").runes.toList()) ?? "None"),

      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Set the border radius here
                child: AspectRatio(
                  // Adjust the aspect ratio as needed
                  aspectRatio: 16 / 12,
                  child: Image.asset("assets/images/c.jpg", fit: BoxFit.fill),
                ),
              ),

              SizedBox(height: 10,),

              Container(
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  // border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15.0), // Set the radius here
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(

                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 0;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: selectedButtonIndex == 0
                              ? Colors.green
                              : Colors.grey, // Change color based on index
                        ),
                        child: Text("প্রাথমিক তথ্য"),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: selectedButtonIndex == 1
                              ? Colors.green
                              : Colors.grey, // Change color based on index
                        ),
                        child: Text("স্বাস্থ্য"),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 2;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: selectedButtonIndex == 2
                              ? Colors.green
                              : Colors.grey, // Change color based on index
                        ),
                        child: Text("প্রজনন"),
                      ),
                    ),
                  ],
                ),
              ),


              selectedButtonIndex == 0 ?BasicInfo(cows: widget.cow,): Container(),
              selectedButtonIndex == 1 ?Health(cows: widget.cow,): Container(),
              selectedButtonIndex == 2 ?Reproduction(cows: widget.cow,): Container(),


            ],
          ),
        ),
      ),
    );
  }
}

class BasicInfo extends StatelessWidget {
  final COW? cows;

  BasicInfo({required this.cows});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsCalender,index: "purchaseDate", title: "ক্রয়ের তারিখ", value: "${cows?.purchaseDate.toString()}" ?? "Purchase Nai", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsOrigin,index: "origin", title: "জাত", value: "${cows?.origin.toString()}" ?? "Origin nai", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsCake,index: "age", title: "বয়স", value: "${cows?.age.toString()}" ?? "Age nai", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsWeight,index: "weight", title: "ওজন", value: "${cows?.weight.toString()}" ?? "Weight nai", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsMilk,index: "milkYield", title: "দুধ উৎপাদন", value: "${cows?.milkYield.toString()}" ?? "MY nai", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsColor,index: "color", title: "রং", value: "${cows?.color.toString()}" ?? "Color nai", cow: cows,),
        // IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsMilk,index: cows?.id ?? -1, title: "Milk Status", value:  "Backend e nai", cow: cows,),
        // IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsOwner,index: cows?.id ?? -1, title: "Ownership", value:  "Backend e nai", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsBreeding,index: "breedingRate", title: "প্রজননের হার", value: "${cows?.breedingRate.toString()}" ?? "BR nai", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsGender,index: "gender", title: "লিঙ্গ", value: "${cows?.gender.toString()}" ?? "Gender nai", cow: cows,),
      ],
    );
  }
}

class Health extends StatelessWidget {
  final COW? cows;

  Health({required this.cows});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsHealth,index: "helthStatus", title: "স্বাস্থ্য অবস্থা", value: "${cows?.helthStatus.toString()}" ?? "HS Nai", cow: cows,),
          SizedBox(height: 10,),
          IndividualFieldShowListPerameter(imgAddress: ImageURL.cattleDetailsCalender,index: "vaccine", title: "ভ্যাকসিন", value: cows?.vaccine ?? ["Vaccine Nai"],cow: cows,),
          IndividualFieldShowListPerameter(imgAddress: ImageURL.cattleDetailsDisease,index: "desease", title: "রোগ", value: cows?.desease ?? ["desease Nai"],cow: cows,),
          IndividualFieldShowListPerameter(imgAddress: ImageURL.cattleDetailsMedicine,index: "medicine", title: "ওষুধ", value: cows?.medicine ?? ["medicine Nai"],cow: cows,),
          SizedBox(height: 10,),
          // IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsVaccine,index: cows?.id ?? -1, title: "Current Vaccine", value: "Backend e Nai", cow: cows,),
          // IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsVaccineDose,index: "currentVaccineDose", title: "*-*-Problem *-*-*- Current Vaccine Dose", value: "${cows?.currentVaccineDose.toString()}" ?? "cvd NAI", cow: cows,),
          // IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsVaccine,index: cows?.id ?? -1, title: "Next Vaccine", value: "Backend e Nai", cow: cows,),
        ],
      ),
    );
  }
}

class Reproduction extends StatelessWidget {
  final COW? cows;

  Reproduction({required this.cows});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(height: 10,),
        IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsCow,index: "provableHeatDate", title: "সম্ভাব্য প্রজননের তারিখ", value: "${cows?.provableHeatDate.toString()}" ?? "PHD Nai", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress: ImageURL.cattleDetailsStatus,index: "heatStatus", title: "প্রজননের অবস্থা", value: "${cows?.heatStatus.toString()}" ?? "Heat Nai" ?? "PHD Nai", cow: cows,),
        // IndividualFieldShowSinglePerameter(imgAddress:ImageURL.cattleDetailsStatus,index: "helthStatus",title: "Health Status" ,value:"${cows?.helthStatus.toString()}" ?? "Helth NAI", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress:ImageURL.cattleDetailsSemen,index: "semenPushStatus", title:"সিমেন পুশ অবস্থা" ,value:"${cows?.semenPushStatus.toString()}" ?? "Semen NAI", cow: cows,),
        // IndividualFieldShowSinglePerameter(imgAddress:ImageURL.cattleDetailsSemen,index: "cows?.id ?? -1", title:"Semen Push Date" ,value: "BACKEND e NAI", cow: cows,),
        // IndividualFieldShowSinglePerameter(imgAddress:ImageURL.cattleDetailsCow,index: "cows?.id ?? -1", title:"Pregnant Status" ,value:"BACKEND e NAI", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress:ImageURL.cattleDetailsCow,index: "pregnantDate",title: "গর্ভবতী তারিখ" ,value:"${cows?.pregnantDate.toString()}" ?? "Pragnenet D NAI", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress:ImageURL.cattleDetailsCow,index: "deliveryStatus", title:"ডেলিভারির অবস্থা" ,value:"${cows?.deliveryStatus.toString()}" ?? "Delivery S NAI", cow: cows,),
        IndividualFieldShowSinglePerameter(imgAddress:ImageURL.cattleDetailsCow,index: "deliveryDate", title:"ডেলিভারি তারিখ" ,value:"${cows?.deliveryDate.toString()}" ?? "Delivery D NAI", cow: cows,),
      ],
    );
  }



}
