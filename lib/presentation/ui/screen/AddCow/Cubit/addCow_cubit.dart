import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Cubit/addCow_states.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/deseaseModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/medicineModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/screen/AddCow/Model/vaccineModel.dart';
import 'package:cow_profile_and_shed_management/presentation/ui/utility/base_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllCow_Cubit extends Cubit<AddCowStates> {
  AllCow_Cubit() : super(Loading()) {
    fetchDiseaseAndVaccineAndMedicine();
  }
  Future<void> fetchDiseaseAndVaccineAndMedicine() async {
    print("*******************");
    final urlDisease = Uri.parse('${AppBaseURL.BaseUrl}alldesease/');
    final urlVaccine = Uri.parse('${AppBaseURL.BaseUrl}allvaccine/');
    final urlMedicine = Uri.parse('${AppBaseURL.BaseUrl}allmedicine/');

    try {
      final responseDisease = await http.get(urlDisease);
      final responseVaccine = await http.get(urlVaccine);
      final responseMedicine = await http.get(urlMedicine);

      try {
        final Map<String, String> headers = {
          'Content-Type': 'application/json; charset=utf-8',
        };
        final responseDisease = await http.get(
            urlDisease,
           headers: headers
        );
        final responseVaccine = await http.get(urlVaccine);
        final responseMedicine = await http.get(urlMedicine);

        if (responseDisease.statusCode == 200 && responseVaccine.statusCode == 200  && responseMedicine.statusCode == 200) {

          final List<dynamic> deseaseData = json.decode(responseDisease.body);
          final List<dynamic> vaccineData = json.decode(responseVaccine.body);
          final List<dynamic> medicineData = json.decode(responseMedicine.body);


          List<DESEASE> desease = deseaseData.map((json) => DESEASE.fromJson(json)).toList();


          String bengaliText = '${desease[0].deseaseName}'; // Replace with your actual encoded text

          List<VACCINE> vaccine = vaccineData.map((json) => VACCINE.fromJson(json)).toList();
          print(vaccine);
          List<MEDICINE> medicine = medicineData.map((json) => MEDICINE.fromJson(json)).toList();
          print(medicine);


          emit(DeseaseAndVaccineAndMedicineList(desease, vaccine,medicine)); // Emit both lists
        } else {
          emit(ErrorState("Error Type : ${responseDisease.statusCode}"));
          print("ERROR FROM ELSE line 39");
        }
      } catch (e) {
        emit(ErrorState("${e.toString()}"));
        print("ERROR FROM Catch From fetchDiseaseAndVaccine");
        throw Exception('Failed to load data');
      }

    } catch (e) {
      emit(ErrorState("${e.toString()}"));
      print("ERROR FROM Catch From fetchDiseaseAndVaccine");
      throw Exception('Failed to load data');
    }
  }

}