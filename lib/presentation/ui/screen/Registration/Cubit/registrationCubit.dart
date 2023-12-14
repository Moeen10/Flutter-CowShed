
import 'package:cow_profile_and_shed_management/presentation/ui/screen/Registration/Cubit/registrationState.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/ShedDetails/shedDetails.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/tokenHolder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationCubit extends Cubit<RegistrationState> {

  RegistrationCubit() : super(InitialState());

  Future<void> doLogin(String name, String email, String password) async {
    print(name);
    final apiUrl = "${AppBaseURL.BaseUrl}register/";

    final requestBody = {
      'name': name,
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Specify the content type
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        // Data was successfully sent to the server
        print('Data sent successfully.');
        print(response.body);
      } else {
        print('Failed to send data. Error:');

      }
    }
    catch (e) {

    }
  }
}
