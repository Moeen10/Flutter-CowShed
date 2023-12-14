class VACCINE {
  int? id;
  String? vaccineName;
  String? vaccineDetails;
  String? vaccineDetailsBangla;

  VACCINE(
      {this.id,
        this.vaccineName,
        this.vaccineDetails,
        this.vaccineDetailsBangla});

  VACCINE.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vaccineName = json['vaccine_name'];
    vaccineDetails = json['vaccine_details'];
    vaccineDetailsBangla = json['vaccine_details_bangla'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vaccine_name'] = this.vaccineName;
    data['vaccine_details'] = this.vaccineDetails;
    data['vaccine_details_bangla'] = this.vaccineDetailsBangla;
    return data;
  }
}
