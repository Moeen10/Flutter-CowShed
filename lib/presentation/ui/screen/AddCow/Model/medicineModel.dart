class MEDICINE {
  int? id;
  String? medicineName;
  String? medicineDetails;
  String? medicineDetailsBangla;

  MEDICINE(
      {this.id,
        this.medicineName,
        this.medicineDetails,
        this.medicineDetailsBangla});

  MEDICINE.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicineName = json['medicine_name'];
    medicineDetails = json['medicine_details'];
    medicineDetailsBangla = json['medicine_details_bangla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['medicine_name'] = this.medicineName;
    data['medicine_details'] = this.medicineDetails;
    data['medicine_details_bangla'] = this.medicineDetailsBangla;
    return data;
  }
}
