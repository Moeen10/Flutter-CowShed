import 'package:cow_profile_and_shed_management/presentation/ui/screen/Login/Cubit/LoginState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/shedDetails.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(InitialState());

  Future<void> doLogin(String email , String password)async{
    emit(LoadingState());


    final apiUrl = AppBaseURL.LoginURl;
    final requestBody = {
      'user_email': email,
      'user_pass': password,
    };

    try {
      print("-------------------------");
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Successful login
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('data') && data['data'].containsKey('token')) {
          String token = data['data']['token'];

          // Set the token value in the GetToken class
          GetToken.setToken(token);
          print('/////////////////////////');
          print(GetToken.token);
        }


        emit(SuccessState());
        Get.offAll(ShedDetails());
      } else {
        // Failed login
        final errorResponse = json.decode(response.body);
        // You can handle the error response here
        print(errorResponse);

        // For now, let's emit an ErrorState.
        emit(ErrorState('Login failed. Please try again.'));
        emit(InitialState());
      }
    } catch (e) {
      // Exception occurred
      print('Exception: $e');

      // For now, let's emit an ErrorState.
      emit(ErrorState(e.toString()));
      emit(InitialState());
    }
  }
}
