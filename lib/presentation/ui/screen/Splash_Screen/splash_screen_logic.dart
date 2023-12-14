import 'package:cow_profile_and_shed_management/presentation/ui/screen/CowProfile/cowDetails.dart';
import 'package:get/get.dart';

import '../landing_page.dart';

class NextpageController extends GetxController{
  @override

  @override
  void onReady() {
    super.onReady();
    _navigateToLoginAfterDelay();
  }

  _navigateToLoginAfterDelay() async {
    // Delay the navigation by 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    // Navigate to the login page
    Get.offAll(LandingPage()); // Replace with your login page route

  }

}