class MilkProduction {
  int? id;
  String? date;
  String? milkProduced;
  int? cow;

  MilkProduction({this.id, this.date, this.milkProduced, this.cow});

  MilkProduction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    milkProduced = json['milk_produced'];
    cow = json['cow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['milk_produced'] = this.milkProduced;
    data['cow'] = this.cow;
    return data;
  }
}