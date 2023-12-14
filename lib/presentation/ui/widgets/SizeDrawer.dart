import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddInventory/AddInventory.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/DeviceControl/deviceControlHomePage.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/InventoryList/InventoryList.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Milk_Section/addMilk.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/addDevice.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/cowProfile.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Expense/expense.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/shedDetails.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/addCow.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/landing_page.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/shedRegistration.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/vaccine&medicine.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);
  Future<void> performLogout() async {
    try {
      final response = await http.post(
        Uri.parse(AppBaseURL.LogoutUrl),
        headers: {
          'Authorization': 'Bearer ${GetToken.token}',
        },
      );

      if (response.statusCode == 200) {
        // Logout successful
        //Make token value ""
        GetToken.setToken("");
        print('Logout successful');
      } else {
        // Logout failed
        print('Logout failed: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception during logout: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Center(
                  child: UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage("https://as2.ftcdn.net/v2/jpg/02/14/74/61/1000_F_214746128_31JkeaP6rU0NzzzdFC4khGkmqc8noe6h.jpg"),
                    ),
                    accountName: Text("Moeen Uddin"),
                    accountEmail: Text("umoeen3@gmail.com"),

                  ),
                ),
                // ListTile(
                //   leading: Icon(Icons.add_home,color: Colors.green,),
                //   title: Text("Shed Registration"),
                //   onTap: () {
                //     Get.to(ShedRegistration());
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.sensors,color: Colors.green,),
                  title: Text("শেডের অবস্থা"),
                  onTap: () {
                    Get.to(ShedDetails());
                  },
                ),
                ListTile(
                  leading:  SvgPicture.asset(
                    "assets/images/addCow.svg",
                    height: 30,
                    width: 30,
                  ),
                  title: Text("গরু যোগ করুন"),
                  onTap: () {
                    Get.to(AddCow());
                  },
                ),
                // ListTile(
                //   leading:  SvgPicture.asset(
                //     "assets/images/deviceAdd.svg",
                //     height: 28,
                //     width: 28,
                //   ),
                //   title: Text("Add Device"),
                //   onTap: () {
                //     Get.to(AddDevice());
                //   },
                // ),
                ListTile(
                  leading:  SvgPicture.asset(
                    "assets/images/expense.svg",
                    height: 28,
                    width: 28,
                  ),
                  title: Text("ইনভেন্টরি আউট করুন"),
                  onTap: () {
                    Get.to(Expense());
                  },
                ),
                ListTile(
                  leading:  SvgPicture.asset(
                    "assets/images/inventory.svg",
                    height: 28,
                    width: 28,
                  ),
                  title: Text("নভেন্টরি যোগ করুন"),
                  onTap: () {
                    Get.to(AddInventory());
                  },
                ),
                ListTile(

                  leading: Image.asset("assets/images/cowMukh.png",height: 35,),
                  title: Text("গরুর প্রোফাইল"),
                  onTap: () {
                    Get.to(CowProfile());
                  },
                ),
                ListTile(
                  leading: Image.asset("assets/images/inventory-4.png",height: 35,),
                  title: Text("পণ্যের তালিকা"),
                  onTap: () {
                    Get.to(InventoryList());

                  },
                ),
                // ListTile(
                //   leading: Image.asset("assets/images/cowMukh.png",height: 35,),
                //   title: Text("Vaccin & Medicine"),
                //   onTap: () {
                //     Get.to(VaccinAndMedicine());
                //   },
                // ),
                ListTile(
                  leading: Image.asset("assets/images/device.png",height: 35,),
                  title: Text("ডিভাইস কন্ট্রোল"),
                  onTap: () {
                    Get.to(DeviceControlHomePage());
                  },
                ),
                ListTile(
                  leading: Image.asset("assets/images/logout.png",height: 35,),
                  title: Text("লগআউট"),
                  onTap: () async{
                    LoadingIndicator();
                    await performLogout();
                    Get.to(LandingPage());
                  },
                ),
              ],

            ),
          ),
        ],
      ),
    );


  }
}

