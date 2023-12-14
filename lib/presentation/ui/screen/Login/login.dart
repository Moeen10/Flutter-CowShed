import 'package:cow_profile_and_shed_management/presentation/ui/screen/Login/Cubit/LoginCubit.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Login/Cubit/LoginState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/shedDetails.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/image_base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<LoginCubit>(context);

            return BlocConsumer<LoginCubit, LoginState>(
              bloc: cubit,
              builder: (context, state) {
                if (state is InitialState) {
                  return SingleChildScrollView(

                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: MediaQuery.of(context).size.height * 1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageURL.registrationBG),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              // Upper part of the screen
                              SizedBox(height: 60,),
                              Container(
                                // height: MediaQuery.of(context).size.height * 0.5,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(ImageURL.cowHead),
                                      SizedBox(height: 20,),
                                      Text("Dairy Care",
                                        style: TextStyle(color: Color(0xff09b256) ,fontSize: 40,fontWeight: FontWeight.w700),
                                      ),
                                      Text("Login To Your Account",
                                        style: TextStyle(color: Color(0xff085423) ,fontSize: 20,fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                // height: MediaQuery.of(context).size.height * 0.5,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("  Email",style: TextStyle(color: Colors.white,fontSize: 20),),
                                      SizedBox(height: 10,),
                                      TextFormField(
                                        cursorColor: Colors.yellow,
                                        controller: email,
                                        decoration: InputDecoration(
                                          filled: true, // This enables filling the background with a color
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Color(0xffd8d7e9))),
                                          hintText: "youremail@gmail.com",
                                          hintStyle: TextStyle(color: Color(0xff868686)) ,
                                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Color(0xffd8d7e9))),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Color(0xffd8d7e9))),
                                        ),

                                      ),
                                      SizedBox(height: 10,),
                                      Text("  Password",style: TextStyle(color: Colors.white,fontSize: 20),),
                                      SizedBox(height: 10,),
                                      TextFormField(
                                        cursorColor: Colors.yellow,
                                        obscureText: true,
                                        controller: password,
                                        decoration: InputDecoration(
                                          filled: true, // This enables filling the background with a color
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Color(0xffd8d7e9))),
                                          hintText: "*********",
                                          hintStyle: TextStyle(color: Color(0xff868686)) ,
                                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Color(0xffd8d7e9))),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Color(0xffd8d7e9))),
                                        ),

                                      ),
                                      SizedBox(height: 15,),
                                      SizedBox(
                                        width: double.infinity,
                                        height:45,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xff198319),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                          ),
                                          onPressed: () {
                                            // Get.offAll(ShedDetails());
                                            cubit.doLogin(email.text, password.text);
                                          },
                                          child: Text("LOGIN"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 100,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                else if(state is LoadingState){
                  return LoadingIndicator();
                }
                else {
                  return Text("data");
                }
              },
              listener: (context, state) {
                // Do something when the state changes.
                if(state is SuccessState){
                  Get.snackbar(
                    backgroundColor: Color(0xff008000),
                    colorText: Color(0xffffffff),
                    "Done",
                    "Login Sucsessfully",
                  );
                }
                else if(state is ErrorState){
                  Get.snackbar(

                    backgroundColor: Color(0xff1DBF02),
                    colorText: Color(0xffffffff),
                    "Failed",
                    "Login Failed"
                    // state.errorMessage.toString(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}