import 'package:cow_profile_and_shed_management/presentation/ui/screen/Login/login.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Registration/registration.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/image_base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Container(
               height: MediaQuery.of(context).size.height * 1, // 100% of the screen height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageURL.loginBottom),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    // Upper part of the screen
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5, // 50% of the screen height

                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome To',
                              style: TextStyle(color: Color(0xff09b256) ,fontSize: 50 , fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 20,),
                            Image.asset(ImageURL.cowHead),
                            SizedBox(height: 20,),
                            Text("Dairy Care",
                                style: TextStyle(color: Color(0xff09b256) ,fontSize: 50,fontWeight: FontWeight.w700),
                      ),
                          ],
                        ),
                      ),
                    ),



                    // Lower part of the screen with a background image
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5, // 50% of the screen height
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 210,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                ),
                                onPressed: () {
                                  Get.to(LoginPage());
                                },
                                child: Text("LOGIN" , style: TextStyle(color: Color(0xff6A6A6A),fontWeight: FontWeight.w700,fontSize: 25),),
                              ),
                            ),
                            SizedBox(height: 10,),
                            SizedBox(
                              width: 210,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                ),
                                onPressed: () {
                                  Get.to(RegistrationPage());
                                },
                                child: Text("REGISTRATION" , style: TextStyle(color: Color(0xff6A6A6A),fontWeight: FontWeight.w700,fontSize: 25),),
                              ),
                            )
                          ],
                        )
                      ),
                    ),
                  ],

                )
              ),
            ),
    );
  }
}
