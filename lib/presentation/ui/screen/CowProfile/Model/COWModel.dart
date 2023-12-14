class COW {
  int? id;
  List<String>? desease;
  List<String>? medicine;
  List<String>? vaccine;
  String? purchaseDate;
  String? cattleId;
  String? origin;
  String? gender;
  int? age;
  String? dateOfBirth;
  String? color;
  String? breedingRate;
  String? weight;
  String? milkYield;
  bool? active;
  String? helthStatus;
  String? currentVaccineDose;
  String? nextVaccineDose;
  String? provableHeatDate;
  String? heatStatus;
  String? actualHeatDate;
  String? semenPushStatus;
  String? pregnantDate;
  String? deliveryStatus;
  String? deliveryDate;
  int? shed;

  COW(
      {this.id,
        this.desease,
        this.medicine,
        this.vaccine,
        this.purchaseDate,
        this.cattleId,
        this.origin,
        this.gender,
        this.age,
        this.dateOfBirth,
        this.color,
        this.breedingRate,
        this.weight,
        this.milkYield,
        this.active,
        this.helthStatus,
        this.currentVaccineDose,
        this.nextVaccineDose,
        this.provableHeatDate,
        this.heatStatus,
        this.actualHeatDate,
        this.semenPushStatus,
        this.pregnantDate,
        this.deliveryStatus,
        this.deliveryDate,
        this.shed});

  COW.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    desease = json['desease'].cast<String>();
    medicine = json['medicine'].cast<String>();
    vaccine = json['vaccine'].cast<String>();
    purchaseDate = json['purchase_date'];
    cattleId = json['cattle_id'];
    origin = json['origin'];
    gender = json['gender'];
    age = json['age'];
    dateOfBirth = json['date_of_birth'];
    color = json['color'];
    breedingRate = json['breeding_rate'];
    weight = json['weight'];
    milkYield = json['milk_yield'];
    active = json['active'];
    helthStatus = json['helth_status'];
    currentVaccineDose = json['current_vaccine_dose'];
    nextVaccineDose = json['next_vaccine_dose'];
    provableHeatDate = json['provable_heat_date'];
    heatStatus = json['heat_status'];
    actualHeatDate = json['actual_heat_date'];
    semenPushStatus = json['semen_push_status'];
    pregnantDate = json['pregnant_date'];
    deliveryStatus = json['delivery_status'];
    deliveryDate = json['delivery_date'];
    shed = json['shed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['desease'] = this.desease;
    data['medicine'] = this.medicine;
    data['vaccine'] = this.vaccine;
    data['purchase_date'] = this.purchaseDate;
    data['cattle_id'] = this.cattleId;
    data['origin'] = this.origin;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['date_of_birth'] = this.dateOfBirth;
    data['color'] = this.color;
    data['breeding_rate'] = this.breedingRate;
    data['weight'] = this.weight;
    data['milk_yield'] = this.milkYield;
    data['active'] = this.active;
    data['helth_status'] = this.helthStatus;
    data['current_vaccine_dose'] = this.currentVaccineDose;
    data['next_vaccine_dose'] = this.nextVaccineDose;
    data['provable_heat_date'] = this.provableHeatDate;
    data['heat_status'] = this.heatStatus;
    data['actual_heat_date'] = this.actualHeatDate;
    data['semen_push_status'] = this.semenPushStatus;
    data['pregnant_date'] = this.pregnantDate;
    data['delivery_status'] = this.deliveryStatus;
    data['delivery_date'] = this.deliveryDate;
    data['shed'] = this.shed;
    return data;
  }
}
